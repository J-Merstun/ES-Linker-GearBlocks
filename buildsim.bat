cd "C:\Users\skye\Documents\ES-Linker-GearBlocks"

git clone --recurse-submodules https://github.com/ange-yaghi/engine-sim sim-win

cd sim-win
rd /s /q build
mkdir build
cd build

cmake -DCMAKE_POLICY_VERSION_MINIMUM=3.5-DBOOST_ROOT="C:/local/boost_1_89_0" -DBoost_LIBRARY_DIRS="C:/local/boost_1_89_0/lib" ..
cmake —build . -Wno-dev 
REM engine-sim-app.exe
cd ../../