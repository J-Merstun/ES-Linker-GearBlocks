rm -rf sim-linux

git clone --recurse-submodules https://github.com/bobsayshilol/engine-sim -b sdl-build sim-linux

cd sim-linux
mkdir build
cd build

CC=clang CXX=clang++ cmake -DCMAKE_BUILD_TYPE=Release ../
cmake --build . --target engine-sim-app -j
./engine-sim-app