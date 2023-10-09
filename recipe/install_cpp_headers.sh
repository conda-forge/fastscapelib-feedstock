#!/bin/bash
set -e

# run tests
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
  cmake -S . \
        -B build/tests \
        ${CMAKE_ARGS} \
        -DFS_BUILD_TESTS=ON \
        -DFS_DOWNLOAD_GTEST=ON

  cmake --build build/tests -- -j${CPU_COUNT}
  cd build/tests
  ctest -T test --output-on-failure
  cd ../..
fi

# install
cmake -S . \
      -B build \
      ${CMAKE_ARGS} \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \

cmake --build build --target install
