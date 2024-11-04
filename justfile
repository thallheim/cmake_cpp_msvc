#set windows-shell := ["pwsh.exe","-NoLogo","-Command"]
set windows-shell := ["C:\\Program Files\\Git\\bin\\sh.exe","-c"]
OS := os()

#BUILD_IMPORT_STMT#
#CONFIG_IMPORT_STMNT#

[no-exit-message]
_default:
    @just configure-just

[no-exit-message]
@configure-just:
    cmake -P "backup_unconfigured_justfile.cmake"
    cmake -P "configure_justfile.cmake"
    
# List available recipes, with fzf previews
[no-exit-message]
@_fuzzy-list:
    # if ! which fzf > /dev/null 2>&1; then \
    # echo "FATAL: fzf not installed." && exit 1; fi
    just --choose --chooser "fzf --no-multi --preview 'just --show {1}' --height=16 --border=rounded"    

