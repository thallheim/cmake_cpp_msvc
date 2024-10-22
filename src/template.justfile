bin_root          := "@REPO_NAME@"
dyn_suffix        := "-dyn"
static_suffix     := "-static"
bin_name_dyn      := bin_root + dyn_suffix
bin_name_static   := bin_root + static_suffix

alias b := build
# Build project
@build:
    if ! which cmake > /dev/null 2>&1; then \
    echo "FATAL: CMake not installed." && exit 1; fi
    echo "============================================"
    echo "CMake: Building project..."
    echo "============================================"
    # cmake -Wdev -Wdeprecated --build build --config "Debug"
    cmake --build build --config "Debug"

alias br := build-release
# Build project
@build-release:
    if ! which cmake > /dev/null 2>&1; then \
    echo "FATAL: CMake not installed." && exit 1; fi
    echo "============================================"
    echo "CMake: Building project..."
    echo "============================================"
    cmake --build build --config "Release"








alias r := run-dyn
alias rd := run-dyn
# Run the thing (debug, dyn. linked)
[windows]
@run-dyn:
    ./build/Debug/{{bin_name_dyn}}.exe

alias rr := run-release-dyn
alias rrd := run-release-dyn
# Run the thing (release, dyn. linked)
[windows]
@run-release-dyn:
    ./build/Release/{{bin_name_dyn}}.exe

alias rs := run-static
# Run the thing (debug, Statically Linked Edition)
[windows]
@run-static:
    ./build/Debug/{{bin_name_static}}.exe

alias rrs := run-release-static
# Run the thing (release, Statically Linked Edition)
[windows]
@run-release-static:
    ./build/Release/{{bin_name_static}}.exe

# Just do it (configure -> build -> run (static))
[windows]
@go: configure-static build run-static
    ./build/Debug/{{bin_name_static}}.exe

# Display available recipes on stdout
list:
    @just --list
