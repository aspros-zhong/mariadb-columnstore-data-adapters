cmake_minimum_required(VERSION 2.8)
project(mxs_adapter)

include(GNUInstallDirs)
include(CheckCXXCompilerFlag)
include(ExternalProject)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# First we need to check if C++11 is supported
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
if(NOT COMPILER_SUPPORTS_CXX11)
  message(FATAL_ERROR "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif()

find_package(LibXml2)
find_package(LibUV)
find_package(Snappy)
find_package(jansson)
find_package(mcsapi)
find_package(CDC)

# Some defaults
set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING
        "Choose the type of build, options are: None(CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used) Debug Release RelWithDebInfo MinSizeRel")

include_directories(${JANSSON_INCLUDE_DIRS})
include_directories(${MCSAPI_INCLUDE_DIRS})
include_directories(${CDC_INCLUDE_DIRS})

# Compiler flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wextra -Wshadow -Werror")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -ggdb")

# Then finally build the adapter itself
add_executable(mxs_adapter mxs_adapter.cpp)
target_link_libraries(mxs_adapter ${CDC_LIBRARIES}
  ${MCSAPI_LIBRARIES} ${LIBUV_LIBRARY} ${LIBXML2_LIBRARIES}
  ${JANSSON_LIBRARIES} crypto ${SNAPPY_LIBRARIES})

# Install the adapter, the license and the readme
install(TARGETS mxs_adapter DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT mxs_adapter)
install(FILES README.md LICENSE.TXT DESTINATION ${CMAKE_INSTALL_DOCDIR} COMPONENT mxs_adapter)
