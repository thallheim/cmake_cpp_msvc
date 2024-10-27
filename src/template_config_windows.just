set windows-shell := ["pwsh.exe","-NoLogo","-Command"]
OS := os()

import? 'build/build.just'


[no-exit-message]
_default:
    @just _fuzzy-list


@configure-just:
    cmake -P "configure_justfile.cmake"
    

# List available recipes, with fzf previews
[no-exit-message]
@_fuzzy-list:
    if ! which fzf > /dev/null 2>&1; then \
    echo "FATAL: fzf not installed." && exit 1; fi
    just --choose --chooser "fzf --no-multi --preview 'just --show {1}' --height=16 --border=rounded"    


import? '@CONFIG_TEMPLATE@'


alias c := configure
# Run CMake project config (debug, dynamically linked)
@configure:
    # if ! which cmake > /dev/null 2>&1; then \
    # echo "FATAL: CMake not installed." && exit 1; fi
    echo "============================================================"
    echo "WINDOWS: Configuring project [dyn. libs; do not link CRT]"
    echo "============================================================"
    cmake -DLINK_STATIC=OFF -DLINK_STATIC_CRT=OFF -B build -S .

alias cs := configure-static
# Run CMake project config (debug, statically linked, incl. CRT)
@configure-static:
    # if ! which cmake > /dev/null 2>&1; then \
    # echo "FATAL: CMake not installed." && exit 1; fi
    echo "============================================================"
    echo "WINDOWS: Configuring project [static libs; link CRT]"
    echo "============================================================"
    cmake -DLINK_STATIC=ON -DLINK_STATIC_CRT=ON -B build -S .
