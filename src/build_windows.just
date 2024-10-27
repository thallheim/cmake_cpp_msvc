bin_root          := "@REPO_NAME@"
proj_name         := "@PROJECT_NAME@"

alias b := build
# Build project
@build:
    # if ! which cmake > /dev/null 2>&1; then \
    # echo "FATAL: CMake not installed." && exit 1; fi
    echo "============================================================"
    echo "CMake: Building project... [Config: Debug]"
    echo "============================================================"
    cmake --build build --config "Debug"

alias br := build-release
# Build project (release configuration)
@build-release:
    # if ! which cmake > /dev/null 2>&1; then \
    # echo "FATAL: CMake not installed." && exit 1; fi
    # echo "============================================================"
    echo "CMake: Building project... [Config: Release]"
    echo "============================================================"
    cmake --build build --config "Release"

alias r := run
# Run the thing
@run: 
    ./build/Debug/{{bin_root}}.exe

alias rr := run-release
# Run the thing
@run-release:
    ./build/Release/{{bin_root}}.exe

# Just do it (configure (static links) -> build -> run)
@go: configure build run
    ./build/Debug/{{bin_root}}.exe

# Display available recipes on stdout
list:
    @just --list
