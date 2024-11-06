cmake_minimum_required(VERSION 3.25)

string(TOLOWER "${CMAKE_HOST_SYSTEM_NAME}" HOST)
set(CONFIG_IMPORT_STMNT "import '.support_scripts/config_${HOST}.just'")
set(JUSTFILE_PATH "${CMAKE_SOURCE_DIR}/justfile")

file(READ ${JUSTFILE_PATH} JUSTFILE_CONTENT)

string(REPLACE "#CONFIG_IMPORT_STMNT#" "${CONFIG_IMPORT_STMNT}" JUSTFILE_CONTENT "${JUSTFILE_CONTENT}")
# Write the build justfile's import statement
string(REPLACE "#BUILD_IMPORT_STMNT#"
  "import? 'build/build.just'"
  JUSTFILE_CONTENT "${JUSTFILE_CONTENT}")
# Comment out the `configure-just` recipe to hide it after first run
string(REPLACE "[no-exit-message]\n@configure-just:\n    cmake -P \".support_scripts/backup_unconfigured_justfile.cmake\"\n    cmake -P \".support_scripts/configure_justfile.cmake\"\n"
  "#[no-exit-message]\n#@configure-just:\n#   cmake -P \".support_scripts/backup_unconfigured_justfile.cmake\"\n#    cmake -P \".support_scripts/configure_justfile.cmake\"\n"
  JUSTFILE_CONTENT "${JUSTFILE_CONTENT}")
# Switch default recipe from `config-just` to `_fuzzy-list`
string(REPLACE "[no-exit-message]\n_default:\n    @just configure-just\n"
  "[no-exit-message]\n_default:\n    @just _fuzzy-list\n"
  JUSTFILE_CONTENT "${JUSTFILE_CONTENT}")
# Enable justfile reset recipe
string(REPLACE "#reset-justfile:\n#    cp -fv ./build/unconfigured.just ./justfile\n"
  "reset-justfile:\n    cp -fv ./build/unconfigured.just ./justfile\n"
  JUSTFILE_CONTENT "${JUSTFILE_CONTENT}")


file(WRITE ${JUSTFILE_PATH} "${JUSTFILE_CONTENT}")
