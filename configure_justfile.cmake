cmake_minimum_required(VERSION 3.25)

set(CONFIG_JUSTFILE_TEMPLATE "")
set(HOST ${CMAKE_HOST_SYSTEM_NAME})

message(${HOST})

if(LINUX)
  set(CONFIG_JUSTFILE_TEMPLATE ${CMAKE_SOURCE_DIR}src/template_config_linux.just)
  configure_file(${CONFIG_JUSTFILE_TEMPLATE} ${CMAKE_BINARY_DIR}/config_linux.just @ONLY)
endif()

if(WIN32)
  set(CONFIG_JUSTFILE_TEMPLATE ${CMAKE_SOURCE_DIR}src/template_config_wimdows.just)
  configure_file(${CONFIG_JUSTFILE_TEMPLATE} ${CMAKE_BINARY_DIR}/config_windows.just @ONLY)
endif()
