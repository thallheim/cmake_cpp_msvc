CONFIG_TEMPLATE := "${CMAKE_SOURCE_DIR}/src/template_config_windows.just"

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
