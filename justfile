set windows-shell := ["pwsh.exe","-NoLogo","-Command"]
OS := os()
# TODO: Can the build.just import be commented out and templated back
# by the main config step instead, to avoid having to check for it
# here? It's not going to exist for at least the first two just calls,
# unless specific recipes are called by name.
import? 'build/build.just'
import? '@CONFIG_IMPORT_STMNT@'


[no-exit-message]
_default:
    @just configure-just

[no-exit-message]
@configure-just:
    echo "YAS"
    cmake -P "configure_justfile.cmake"
    
# List available recipes, with fzf previews
[no-exit-message]
@_fuzzy-list:
    # if ! which fzf > /dev/null 2>&1; then \
    # echo "FATAL: fzf not installed." && exit 1; fi
    just --choose --chooser "fzf --no-multi --preview 'just --show {1}' --height=16 --border=rounded"    

