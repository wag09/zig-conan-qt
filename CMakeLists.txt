cmake_minimum_required(VERSION 3.15)
project(MyQtProject)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Include Conan-generated files (after conan install)
include(${CMAKE_BINARY_DIR}/conan_toolchain.cmake)
find_package(Qt5 REQUIRED COMPONENTS Core Gui Widgets QXcbIntegrationPlugin)

add_executable(myapp main.cpp)
target_link_libraries(myapp PRIVATE Qt5::Core Qt5::Gui Qt5::Widgets Qt5::QXcbIntegrationPlugin)