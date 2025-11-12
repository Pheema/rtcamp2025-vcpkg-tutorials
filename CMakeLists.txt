cmake_minimum_required(VERSION 3.21)

project(vcpkg-example LANGUAGES CXX)

add_executable(hello-vcpkg)

target_include_directories(hello-vcpkg PUBLIC include)
target_sources(hello-vcpkg PRIVATE src/main.cpp)

target_compile_features(hello-vcpkg PRIVATE cxx_std_20)

find_package(fmt REQUIRED)
find_package(argparse REQUIRED)
find_package(fpng REQUIRED) # 自前 port file のサンプル用 (vcpkg/ports/fpng/)

target_link_libraries(hello-vcpkg PRIVATE fmt::fmt argparse::argparse
                                          fpng::fpng)

set_property(DIRECTORY PROPERTY VS_STARTUP_PROJECT hello-vcpkg)
