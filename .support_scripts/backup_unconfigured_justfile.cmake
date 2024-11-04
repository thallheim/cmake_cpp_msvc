cmake_minimum_required(VERSION 3.25)

set(JUSTFILE_PATH "${CMAKE_SOURCE_DIR}/justfile")

file(READ ${JUSTFILE_PATH} JUSTFILE_CONTENT)
file(WRITE ${CMAKE_BINARY_DIR}/build/unconfigured.just "${JUSTFILE_CONTENT}")
