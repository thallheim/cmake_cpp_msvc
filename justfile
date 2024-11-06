#set windows-shell := ["pwsh.exe","-NoLogo","-Command"]
set windows-shell := ["C:\\Program Files\\Git\\bin\\sh.exe","-c"]
OS := os()


# IMPORT STATEMENTS -- DO NOT MODIFY
# ¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
# Justfile recipes aren't cross-platform. A CMake string-replace is
# therefore used to write platform-specific import paths in place of
# the lines below. See `configure_justfile.cmake` in the
# `.support_scripts` dir for details.
#
# After the first run CMake will not touch this justfile, so
# recipes or imports can safely be added to it.

#BUILD_IMPORT_STMNT#
#CONFIG_IMPORT_STMNT#

# ¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨


[no-exit-message]
_default:
    @just configure-just

[no-exit-message]
@configure-just:
    cmake -P ".support_scripts/backup_unconfigured_justfile.cmake"
    cmake -P ".support_scripts/configure_justfile.cmake"
    
# List available recipes, with fzf previews
[no-exit-message]
@_fuzzy-list:
    # if ! which fzf > /dev/null 2>&1; then \
    # echo "FATAL: fzf not installed." && exit 1; fi
    just --choose --chooser "fzf --no-multi --preview 'just --show {1}' --height=16 --border=rounded"    

# Reset root justfile to its unconfigured state
#reset-justfile:
#    cp -fv ./build/unconfigured.just ./justfile
