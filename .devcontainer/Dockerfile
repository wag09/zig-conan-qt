FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    git perl python3 python3-pip python3-venv build-essential pkg-config \
    libgl1-mesa-dev libfontconfig1-dev libfreetype6-dev libx11-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev \
    libxcb1-dev libx11-xcb-dev libxcb-glx0-dev libxkbcommon-x11-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev \
    libxcb-icccm4-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev \
    libsqlite3-dev libssl-dev libicu-dev libjpeg-dev libpng-dev zlib1g-dev \
    cmake wget tar xz-utils \
    libfontenc-dev libice-dev libsm-dev libxau-dev libxaw7-dev libxcomposite-dev libxcursor-dev libxdamage-dev libxinerama-dev libxkbfile-dev libxmu-dev libxmuu-dev libxpm-dev libxres-dev libxss-dev libxt-dev libxtst-dev libxv-dev libxxf86vm-dev libxcb-xinerama0-dev libxcb-cursor-dev libxcb-dri2-0-dev libxcb-dri3-dev libxcb-present-dev libxcb-composite0-dev libxcb-ewmh-dev libxcb-res0-dev libxrandr-dev libxcb-util-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Zig (adjust version if needed; check https://ziglang.org/download/)
RUN wget https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz && \
    tar -xvf zig-linux-x86_64-0.13.0.tar.xz && \
    mv zig-linux-x86_64-0.13.0 /usr/local/zig && \
    ln -s /usr/local/zig/zig /usr/local/bin/zig && \
    rm zig-linux-x86_64-0.13.0.tar.xz

# Create wrapper scripts for Zig tools (avoids CMake issues with spaces in compiler names)
RUN echo '#!/bin/sh\nexec zig cc "$@"' > /usr/local/bin/zig-cc && chmod +x /usr/local/bin/zig-cc
RUN echo '#!/bin/sh\nexec zig c++ "$@"' > /usr/local/bin/zig-cxx && chmod +x /usr/local/bin/zig-cxx
RUN echo '#!/bin/sh\nexec zig ar "$@"' > /usr/local/bin/zig-ar && chmod +x /usr/local/bin/zig-ar
RUN echo '#!/bin/sh\nexec zig ranlib "$@"' > /usr/local/bin/zig-ranlib && chmod +x /usr/local/bin/zig-ranlib
RUN echo '#!/bin/sh\nexec zig cc "$@"' > /usr/local/bin/clang && chmod +x /usr/local/bin/clang
RUN echo '#!/bin/sh\nexec zig c++ "$@"' > /usr/local/bin/clang++ && chmod +x /usr/local/bin/clang++
RUN echo '#!/bin/sh\nexec zig ar "$@"' > /usr/local/bin/llvm-ar && chmod +x /usr/local/bin/llvm-ar
RUN echo '#!/bin/sh\nexec zig ranlib "$@"' > /usr/local/bin/llvm-ranlib && chmod +x /usr/local/bin/llvm-ranlib
RUN echo '#!/bin/sh\nexec zig objcopy "$@"' > /usr/local/bin/llvm-objcopy && chmod +x /usr/local/bin/llvm-objcopy
RUN echo '#!/bin/sh\nexec zig strip "$@"' > /usr/local/bin/llvm-strip && chmod +x /usr/local/bin/llvm-strip

# Create a virtual environment for Conan and install it there (avoids externally-managed-environment error)
RUN python3 -m venv /opt/conan_venv && \
    /opt/conan_venv/bin/pip install --no-cache-dir conan

# Add the virtual environment to PATH
ENV PATH="/opt/conan_venv/bin:${PATH}"

# Set up Conan cache dir (no init needed; Conan 2.x handles it automatically)
ENV CONAN_USER_HOME=/conan
RUN mkdir /conan

# Add Zig to PATH
ENV PATH=/usr/local/zig:$PATH

# Install prebuilt Just binary (avoids Rust installation)
RUN wget https://github.com/casey/just/releases/download/1.42.2/just-1.42.2-x86_64-unknown-linux-musl.tar.gz -O just.tar.gz && \
    tar -xzf just.tar.gz just && \
    mv just /usr/local/bin/just && \
    chmod +x /usr/local/bin/just && \
    rm just.tar.gz
