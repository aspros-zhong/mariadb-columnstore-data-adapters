# Download and build the ColumnStore Bulk Load API

set(MCSAPI_REPO "https://github.com/mariadb-corporation/mariadb-columnstore-api.git" CACHE INTERNAL "")

ExternalProject_Add(mcsapi
 GIT_REPOSITORY ${MCSAPI_REPO}
 CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/mcsapi/install -DCMAKE_INSTALL_LIBDIR=${CMAKE_INSTALL_LIBDIR}
 BUILD_IN_SOURCE 1
 INSTALL_DIR ${CMAKE_BINARY_DIR}/mcsapi/install
 UPDATE_COMMAND "")

set(MCSAPI_FOUND TRUE CACHE INTERNAL "")
set(MCSAPI_STATIC_FOUND TRUE CACHE INTERNAL "")
set(MCSAPI_INCLUDE_DIR ${CMAKE_BINARY_DIR}/mcsapi/install/include CACHE INTERNAL "")
set(MCSAPI_STATIC_LIBRARIES ${CMAKE_BINARY_DIR}/mcsapi/install/${CMAKE_INSTALL_LIBDIR}/libmcsapi.a CACHE INTERNAL "")
set(MCSAPI_LIBRARIES ${MCSAPI_STATIC_LIBRARIES} CACHE INTERNAL "")
