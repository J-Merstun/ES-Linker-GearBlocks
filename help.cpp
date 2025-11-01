#include <iostream>
#include <fstream>
#include <string>
#include <chrono>
#include <thread>

using namespace std;

int help()
{
  ofstream SetLua;
  string line;
SetLua.open("D:/SteamLibrary/steamapps/common/GearBlocks/BepInEx/LogOutput.log");
  if (SetLua.is_open())
  {
   while (getline(SetLua, line))
    {
      cout << line << endl;
      if (line = "[Message:     Unity] Lua: Throttle = 0") {int Torque = 0}
      if (line = "[Message:     Unity] Lua: Throttle = 1") {int Torque = 100}
      std::this_thread::sleep_for(std::chrono::milliseconds(7));
    }
    SetLua.close();
  }

    int RPM = 1000;
    int Torque = 0;
    int Brake = 0;

        SetLua.open("C:/Users/Owner/AppData/LocalLow/SmashHammer Games/GearBlocks/ScriptMods/ES-Linker-GearBlocks/ESOutput.lua");
        SetLua << "local ESOutput = {}\n\nESOutput.RPM = " + to_string(RPM) + "\nESOutput.Torque = " + to_string(Torque) + "\nESOutput.Brake = " + to_string(Brake) + "\nreturn ESOutput";
        SetLua.close();

    return 0;
}

//X-X will probrably hate this "code"...
// i have no idea why "getline" is red, not the "if( line ="