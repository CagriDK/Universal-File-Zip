cmake_minimum_required(VERSION 3.0.0)
project(LoggerApp VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(CTest)
enable_testing()

include_directories(${CMAKE_CURRENT_LIST_DIR}/include)
include_directories(${CMAKE_CURRENT_LIST_DIR}/Dependencies/include/libzip)

add_executable(LoggerApp main.cpp)

target_link_libraries(LoggerApp PRIVATE 
${CMAKE_CURRENT_LIST_DIR}/Dependencies/lib/zip.lib) 

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
