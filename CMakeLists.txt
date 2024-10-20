# TODO: Hammer justfile template into shape
# TODO: README.md (maybe also have CM template it on first run?)
#
cmake_minimum_required(VERSION 3.30)
# Gen. compile_commands.json (no effect with msvc)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 17)

# Check if initial config has been done already
if(NOT DEFINED CACHE{FIRST_RUN})
  set(FIRST_RUN TRUE CACHE BOOL "Indicates whether this is the initial (config) CMake run")
  message(STATUS "FIRST_RUN: ${FIRST_RUN}")
  # See if we've got git
  set(HAVE_GIT FALSE CACHE BOOL "Indicates whether git is available")
  find_program(HAVE_GIT git)
else()
  set(FIRST_RUN FALSE)
  message(NOTICE "FIRST_RUN: ${FIRST_RUN}")
endif()


# Set project name to match git repo name, if present, which
# it should be, assuming it was cloned from the template.
if((HAVE_GIT) AND (EXISTS "${CMAKE_SOURCE_DIR}/.git"))
  set(REPO_NAME "" CACHE STRING "Name of parent repo")
  set(REPO_PATH "" CACHE PATH "Path to parent repo")
  message(NOTICE "Setting project name set to match repo")
  execute_process(
    COMMAND git rev-parse --show-toplevel
    OUTPUT_VARIABLE REPO_PATH
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  get_filename_component(REPO_NAME ${REPO_PATH} NAME)
  set(REPO_NAME ${REPO_NAME} CACHE STRING "Name of parent repo")
  project(${REPO_NAME})
else()
  project("cmake_cpp_msvc_starter_thing")
  set(REPO_NAME "cmake_cpp_msvc_starter_thing")
  message(WARNING "Project doesn't appear to be a git repo. Project name defaulted to `cmake_cpp_msvc_starter_thing`")
endif()

######################################################################
# JUSTFILE GEN                                                       #
######################################################################
set(JUSTFILE_PATH ${CMAKE_SOURCE_DIR}/justfile)
if( (FIRST_RUN) AND (NOT EXISTS ${CMAKE_BINARY_DIR}/build.justfile) )
  message("No justfile at project root: Generating from template")
  set(TEMPLATE_JUSTFILE ${CMAKE_SOURCE_DIR}/src/template.justfile)
  configure_file(${TEMPLATE_JUSTFILE} ${CMAKE_BINARY_DIR}/build.just @ONLY)
endif()

######################################################################
# VCPKG                                                              #
######################################################################
if (WIN32)
  set(VCPKG_CMAKEFILE C:/vcpkg/scripts/buildsystems/vcpkg.cmake)
  if (EXISTS ${VCPKG_CMAKEFILE})
    set(CMAKE_TOOLCHAIN_FILE ${VCPKG_CMAKEFILE})
    # Dyn. linking is default on Win. Define 'LINK_STATIC' or call with
    # -DLINK_STATIC to link statically instead
    if(LINK_STATIC)
      set(VCPKG_TARGET_TRIPLET "x64-windows-static")
    endif()
  else()
    message(WARNING "Couldn't find vcpkg cmake file")
  endif()
endif (WIN32)

if (LINUX)
  set(VCPKG_CMAKEFILE_LINUX "$ENV{HOME}/vcpkg/scripts/buildsystems/vcpkg.cmake")
  if(EXISTS ${VCPKG_CMAKEFILE_LINUX})
    set(CMAKE_TOOLCHAIN_FILE ${VCPKG_CMAKEFILE_LINUX})
  elseif()
    set(CMAKE_TOOLCHAIN_FILE /usr/local/vcpkg/scripts/buildsystems/vcpkg.cmake)
  else()
    message(WARNING "Couldn't find vcpkg cmake file")
  endif()
endif (LINUX)

if (MSVC)
  add_compile_options(/nologo)
  # Static linking of C++ runtime
  if(LINK_STATIC)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
  endif()
else()
    add_compile_options(-Wall -Wextra -Wpedantic)
endif()

######################################################################
# EXTERNAL LIBS/CONTENT                                              #
######################################################################


######################################################################
# SOURCE GLOBS                                                       #
######################################################################
set(SRC)
file(GLOB SRC
  src/*.h src/*.hpp
  src/*.c src/*.cpp
)

######################################################################
# TARGETS & LINKS                                                    #
######################################################################
if(LINK_STATIC)
  add_executable(${PROJECT_NAME}-static ${SRC})
  target_compile_options(${PROJECT_NAME}-static
    PRIVATE
    "/W3" "/Zi" "/cgthreads8")
else()
  add_executable(${PROJECT_NAME}-dyn ${SRC})
  target_compile_options(${PROJECT_NAME}-dyn
    PRIVATE
    "/W3" "/Zi" "/cgthreads8")
endif()

######################################################################
# TARGET INCLUDES                                                    #
######################################################################
# find_package(fmt CONFIG REQUIRED)

# target_link_libraries(SDL3_msvc_template-dyn
#   PRIVATE
#   fmt::fmt
#   # Unnecessary on Win (it uses LoadLibrary, I think) but useful in case
#   # a bout of cross-compilation breaks out.
#   ${CMAKE_DL_LIBS}
# )

# TODO: Conditionalise
set(OUT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/build/Debug")
