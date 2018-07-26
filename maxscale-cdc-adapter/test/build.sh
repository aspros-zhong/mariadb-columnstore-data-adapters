#!/bin/bash

cd $(dirname $(realpath $0))

docker exec -i adapter bash <<EOF
rm -rf /src/
EOF

docker cp ../../ adapter:/src/

docker exec -i adapter bash <<EOF
# The adapter itself
cd /src/maxscale-cdc-adapter/
test -d build || mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make
make install
EOF
