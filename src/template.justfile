bin_root          := "@REPO_NAME@"
proj_name         := "@PROJECT_NAME@"
dyn_suffix        := "-dyn"
static_suffix     := "-static"
bin_name_dyn      := bin_root + dyn_suffix
bin_name_static   := bin_root + static_suffix

alias b := build
# Build project
@build:
    if ! which cmake > /dev/null 2>&1; then \
    echo "FATAL: CMake not installed." && exit 1; fi
    echo "============================================================"
    echo "CMake: Building project... [Config: Debug]"
    echo "============================================================"
    cmake --build build --config "Debug"

alias br := build-release
# Build project (release configuration)
@build-release:
    if ! which cmake > /dev/null 2>&1; then \
    echo "FATAL: CMake not installed." && exit 1; fi
    echo "============================================================"
    echo "CMake: Building project... [Config: Release]"
    echo "============================================================"
    cmake --build build --config "Release"


alias r := run
# Run the thing
[windows]
@run: 
    ./build/Debug/{{bin_root}}.exe

alias rr := run-release
# Run the thing
[windows]
@run-release:
    ./build/Release/{{bin_root}}.exe


# Just do it (configure (static links) -> build -> run)
[windows]
@go: configure-static build run
    ./build/Debug/{{bin_name_static}}.exe

# Display available recipes on stdout
list:
    @just --list
