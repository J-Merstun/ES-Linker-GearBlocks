
git clone --recurse-submodules https://github.com/killgriff22/engine-sim sim-win

cd sim-win
rd /s /q build
mkdir build
cd build

cmake .. -Wno-dev 
cmake —build . -Wno-dev 
REM engine-sim-app.exe
cd ../../