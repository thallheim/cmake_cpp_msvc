# set windows-shell := ["C:\\Program Files\\Git\\bin\\sh.exe","-c"]
set windows-shell := ["pwsh.exe","-NoLogo","-Command"]
OS := os()

import? 'build/build.just'


[no-exit-message]
_default:
    @just _fuzzy-list

# List available recipes, with fzf previews
[no-exit-message]
@_fuzzy-list:
    if ! which fzf > /dev/null 2>&1; then \
    echo "FATAL: fzf not installed." && exit 1; fi
    just --choose --chooser "fzf --no-multi --preview 'just --show {1}' --height=16 --border=rounded"    

# -------------------- Config loader --------------------
config:
    @if [[ "{{OS}}" == "linux" ]]; then \
        just --justfile src/template_config_linux.just; \
    elif [[ "{{OS}}" == "windows" ]]; then \
        just --justfile src/template_config_windows.just; \
    else \
        echo "Unsupported OS: {{OS}}" && exit 1; \
    fi
# -------------------------------------------------------

# alias c := configure
# # Run CMake project config (debug, dynamically linked)
# @configure:
#     if ! which cmake > /dev/null 2>&1; then \
#     echo "FATAL: CMake not installed." && exit 1; fi
#     echo "============================================================"
#     echo "CMake: Configuring project [dyn. libs; do not link CRT]"
#     echo "============================================================"
#     cmake -DLINK_STATIC=OFF -DLINK_STATIC_CRT=OFF -B build -S .

# alias cs := configure-static
# # Run CMake project config (debug, statically linked, incl. CRT)
# @configure-static:
#     if ! which cmake > /dev/null 2>&1; then \
#     echo "FATAL: CMake not installed." && exit 1; fi
#     echo "============================================================"
#     echo "CMake: Configuring project [static libs; link CRT]"
#     echo "============================================================"
#     cmake -DLINK_STATIC=ON -DLINK_STATIC_CRT=ON -B build -S .

# alias purge := purge-build-artefacts
# [confirm('Confirm purge all build artefacts?')]
# @purge-build-artefacts:
#     echo "============================================================"
#     echo "Purging all build artefacts..."
#     echo "============================================================"
#     rm -rf ./build/
#     rm -rf ./src/extern/*
