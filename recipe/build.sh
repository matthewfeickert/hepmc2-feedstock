#!/usr/bin/env bash
# Enable bash strict mode
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

cmake -LAH \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -Dmomentum:STRING=GEV -Dlength:STRING=MM \
    -S source \
    -B build

cmake --build build --clean-first --parallel="${CPU_COUNT}"

if [ "$(uname)" == "Linux" ]; then
make test
fi

cmake --install build
exit 0
