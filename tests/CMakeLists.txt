file (GLOB_RECURSE TEST_SOURCE 
    ${PROJECT_SOURCE_DIR}/tests/test_*.cpp
)

add_executable(${PROJECT_NAME}_tests
    ${TEST_SOURCE}
)

find_package(GTest REQUIRED) # Here to use conan package

target_link_libraries(${PROJECT_NAME}_tests
    GTest::gtest
    GTest::gtest_main
)

enable_testing()
add_test(NAME ${PROJECT_NAME}_tests COMMAND ${PROJECT_NAME}_tests)