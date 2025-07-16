set quiet

default: build

export-recipes:
    conan export recipes/freetype/meson --version 2.13.2
    conan export recipes/fontconfig/all --version 2.15.0
    conan export recipes/xkbcommon/all --version 1.5.0
    conan export recipes/qt/5.x.x --version 5.15.16

install-deps: export-recipes
    conan install . --output-folder=build --build=missing -pr:a {{justfile_directory() + "/.devcontainer/zig_profile"}}

configure: install-deps
    cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=build/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release

build: configure
    cmake --build build --parallel $(nproc)