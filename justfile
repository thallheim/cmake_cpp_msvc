set windows-shell := ["pwsh.exe","-NoLogo","-Command"]
OS := os()

import? 'build/build.just'
import? '@CONFIG_TEMPLATE@'


[no-exit-message]
_default:
    @just _fuzzy-list


@configure-just:
    echo "YAS"
    cmake -P "configure_justfile.cmake"
    
# List available recipes, with fzf previews
[no-exit-message]
@_fuzzy-list:
    if ! which fzf > /dev/null 2>&1; then \
    echo "FATAL: fzf not installed." && exit 1; fi
    just --choose --chooser "fzf --no-multi --preview 'just --show {1}' --height=16 --border=rounded"    

