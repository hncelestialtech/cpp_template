cmake_minimum_required(VERSION 3.17)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(PROJECT_NAME cpp_template)
project(${PROJECT_NAME})

# Set compile options
add_compile_options(
    -std=c++20
    -g
    -Wall
)

if (BUILD_TYPE STREQUAL "Test")
    add_subdirectory(tests)
endif()

