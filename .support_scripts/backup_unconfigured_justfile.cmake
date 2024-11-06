cmake_minimum_required(VERSION 3.25)

set(JUSTFILE_PATH "${CMAKE_SOURCE_DIR}/justfile")
set(BACKUP_PATH "${CMAKE_BINARY_DIR}/build/unconfigured.just")

if(EXISTS ${BACKUP_PATH})
  message(STATUS "Skip root justfile backup - backup exists")
else()
  file(READ ${JUSTFILE_PATH} JUSTFILE_CONTENT)
  file(WRITE ${CMAKE_BINARY_DIR}/build/unconfigured.just "${JUSTFILE_CONTENT}")
  message(STATUS "Backup (unconfigured) root justfile created at: '${BACKUP_PATH}'")
endif()
