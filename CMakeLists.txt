# TODO: (Maybe) Conditionalise justfile gen
# TODO: README.md (maybe also have CM template it on first run?)
# TODO: Opts and things for Linux build
#
cmake_minimum_required(VERSION 3.30)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON) # Generate compile_commands.json (no effect with msvc)
set(CMAKE_CXX_STANDARD 17)


# CACHERY
################################################################################
set(REPO_NAME "" CACHE STRING "Name of parent repo")
set(REPO_PATH "" CACHE PATH "Path to parent repo")


# VCPKG TOOLCHAIN
################################################################################
option(USE_VCPKG "Enable/disable the vcpkg toolchain. Defaults to ON" ON)
# --- WINDOWS
if((WIN32) AND (USE_VCPKG))
  set(VCPKG_CMAKEFILE C:/vcpkg/scripts/buildsystems/vcpkg.cmake)
  if(EXISTS ${VCPKG_CMAKEFILE})
    set(CMAKE_TOOLCHAIN_FILE ${VCPKG_CMAKEFILE})
    message(DEBUG "Found vcpkg toolchain file.")
    # Dyn. linking is default on Win.
    if(LINK_STATIC)
      set(VCPKG_TARGET_TRIPLET "x64-windows-static")
    endif()
  else()
    message(WARNING "Couldn't find vcpkg cmake file at `${VCPKG_CMAKEFILE}`.
        Specify its path manually or disable vcpkg integration.")
  endif()
endif()

# --- LINUX
if((LINUX) AND (USE_VCPKG))
  set(VCPKG_CMAKEFILE_LINUX "$ENV{HOME}/vcpkg/scripts/buildsystems/vcpkg.cmake")
  if(EXISTS ${VCPKG_CMAKEFILE_LINUX})
    set(CMAKE_TOOLCHAIN_FILE ${VCPKG_CMAKEFILE_LINUX})
    message(DEBUG "Found vcpkg toolchain file from `/home` root.")
  elseif()
    set(CMAKE_TOOLCHAIN_FILE /usr/local/vcpkg/scripts/buildsystems/vcpkg.cmake)
    message(DEBUG "No toolchain file under home path. Trying `/usr/local`.")
  else()
    message(WARNING "Couldn't find vcpkg cmake file at `${VCPKG_CMAKEFILE}`.
        Specify its path manually or disable vcpkg integration.")
  endif()
endif()


# PROJECT NAME
################################################################################
# Set project name to match git repo name, if the project is one (it should be,
# if it was cloned from the template). Only done at first run. Sets a default
# name if no repo was found.
# set(REPO_NAME "" CACHE STRING "Name of parent repo")
# set(REPO_PATH "" CACHE PATH "Path to parent repo")
if(EXISTS "${CMAKE_SOURCE_DIR}/.git")
  message(NOTICE "Setting project name to match repo")
  execute_process(
    COMMAND git rev-parse --show-toplevel
    OUTPUT_VARIABLE REPO_PATH
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  get_filename_component(REPO_NAME ${REPO_PATH} NAME)
  set(REPO_NAME ${REPO_NAME} CACHE STRING "Name of parent repo")
  project(${REPO_NAME})
elseif(NOT EXISTS "${CMAKE_SOURCE_DIR}/.git")
  project("cmake_cpp_msvc_starter_thing")
  set(REPO_NAME "cmake_cpp_msvc_starter_thing")
  message(NOTICE "Project doesn't appear to be a git repo.
    Project name defaulted to `cmake_cpp_msvc_starter_thing`")
else()
  message(AUTHOR_WARNING "NO GIT OR NOT A REPO")
endif()


# JUSTFILE GEN
################################################################################
# The result is written to `build.just` to avoid having to touch the root
# justfile, which instead just includes `build.just` after config. This has a
# bonus UX benefit in not showing the build-stage recipes prior to actually
# configuring the build system.
################################################################################
set(JUSTFILE_PATH ${CMAKE_SOURCE_DIR}/justfile)
if(NOT EXISTS ${CMAKE_BINARY_DIR}/build.justfile)
  message("Generating build-justfile from template")
  set(TEMPLATE_JUSTFILE ${CMAKE_SOURCE_DIR}/src/template.justfile)
  configure_file(${TEMPLATE_JUSTFILE} ${CMAKE_BINARY_DIR}/build.just @ONLY)
endif()


# BUILD OPTS
################################################################################
set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "Supported build types")


# LINK OPTS
################################################################################
# Defaults to dynamic lib & runtime linking. This is MSVC default behaviour,
# but is explicitly set here for clarity.
# option(BUILD_SHARED_LIBS "Build libs as shared (DLLs)." ON)
option(LINK_STATIC, "Links project statically if ON. Default: OFF")
option(LINK_STATIC_CRT, "Links C++ runtime statically if ON. Default: OFF")

if (MSVC)
  # CRT
  if(LINK_STATIC_CRT)
    # set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")
  else()
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")
  endif()
  if(LINK_STATIC)
    set(BUILD_SHARED_LIBS ON)
    message(NOTICE "LINKING STATICALLY")
  endif()
endif()


# EXTERNAL LIBS/CONTENT
################################################################################


# SOURCE GLOBS
################################################################################
set(SRC)
file(GLOB SRC
  src/*.h src/*.hpp
  src/*.c src/*.cpp
)


# TARGETS
################################################################################
# TODO: Gen expr?
add_executable(${REPO_NAME} ${SRC})


# COMPILATION OPTS
################################################################################
if (MSVC)
  # target_compile_options(${PROJECT_NAME} PUBLIC
  target_compile_options(${REPO_NAME} PUBLIC
    "$<$<CONFIG:Debug>:/nologo;/cgthreads8;/W4>"
    "$<$<CONFIG:Release>:/nologo;/cgthreads8;/W4>"
  )
endif()

if (LINUX)
  # target_compile_options(${PROJECT_NAME} PUBLIC
  target_compile_options(${REPO_NAME} PUBLIC
    "$<$<CONFIG:Debug>:-j8;-Wall;-Wextra>"
    "$<$<CONFIG:Release>:-j8;-Wall;-Wextra>"
  )
endif()


# TARGET INCLUDES
################################################################################
# find_package(fmt CONFIG REQUIRED)

# target_link_libraries(SDL3_msvc_template-dyn
#   PRIVATE
#   fmt::fmt
#   # Unnecessary on Win (it uses LoadLibrary, I think) but useful in case
#   # a bout of cross-compilation breaks out.
#   ${CMAKE_DL_LIBS}
# )


# MISC.
################################################################################
