
cmake -S . ^
      -B build ^
      %CMAKE_ARGS% ^
      -G"NMake Makefiles" ^
      -DCMAKE_PREFIX_PATH="%PREFIX%" ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DFS_BUILD_TESTS=ON ^
      -DFS_DOWNLOAD_GTEST=ON
if errorlevel 1 exit 1

cmake --build build ^
      --config Release ^
      --target install
if errorlevel 1 exit 1

cd build
ctest --output-on-failure
if errorlevel 1 exit 1
