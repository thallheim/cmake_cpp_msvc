cmake_minimum_required(VERSION 3.25)
include(CMakePrintHelpers)

set(CONFIG_JUSTFILE_TEMPLATE "")
string(TOLOWER "${CMAKE_HOST_SYSTEM_NAME}" HOST)
set(CONFIG_TEMPLATE "${CMAKE_SOURCE_DIR}/src/template_config_${HOST}.just")

if(WIN32)
  set(CONFIG_JUSTFILE_TEMPLATE ${CMAKE_SOURCE_DIR}/src/template_config_windows.just)
  # cmake_print_variables(${CONFIG_JUSTFILE_TEMPLATE} ${HOST} ${CMAKE_HOST_SYSTEM_NAME})
  configure_file(${CONFIG_JUSTFILE_TEMPLATE} ${CMAKE_SOURCE_DIR}/justfile @ONLY)
endif()

if(LINUX)
  set(CONFIG_JUSTFILE_TEMPLATE ${CMAKE_SOURCE_DIR}/src/template_config_linux.just)
  # cmake_print_variables(${CONFIG_JUSTFILE_TEMPLATE} ${HOST} ${CMAKE_HOST_SYSTEM_NAME})
  configure_file(${CONFIG_JUSTFILE_TEMPLATE} ${CMAKE_SOURCE_DIR}/justfile @ONLY)
endif()
