#include <iostream>
#include <fstream>
#include <string>
#include <chrono>
#include <thread>

using namespace std;

int main()
{
    ifstream GetLua;
    ofstream SetLua;
    string line;
    
    int Torque = 0;
    int RPM = 1000;
    int Brake = 0;
    
    GetLua.open("D:/SteamLibrary/steamapps/common/GearBlocks/BepInEx/LogOutput.log");
    if (GetLua.is_open())
    {
        while (getline(GetLua, line))
        {
            cout << line << endl;
            if (line == "[Message:     Unity] Lua: Throttle = 0") {int Torque = 0;}
            if (line == "[Message:     Unity] Lua: Throttle = 1") {int Torque = 100;}
            std::this_thread::sleep_for(std::chrono::milliseconds(7));
        }
        GetLua.close();
    }
    
    SetLua.open("C:/Users/Owner/AppData/LocalLow/SmashHammer Games/GearBlocks/ScriptMods/ES-Linker-GearBlocks/ESOutput.lua");
    SetLua << "local ESOutput = {}\n\nESOutput.RPM = ";
    SetLua << to_string(RPM);
    SetLua << "\nESOutput.Torque = ";
    SetLua << to_string(Torque);
    SetLua << "\nESOutput.Brake = ";
    SetLua << to_string(Brake);
    SetLua << "\nreturn ESOutput";
    SetLua.close();
    
    return 0;
}

//X-X will probrably hate this "code"...
// i have no idea why "getline" is red, not the "if( line ="
//
//
//#include <iostream>
//#include <fstream>
//#include <string>
//#include <chrono>
//#include <thread>
//
//using namespace std;
//
//
//int main() {
//    ifstream GetLua;
//    ofstream GetLua;
//    string line;
//    
//    int RPM = 1000;
//    int Torque = 0;
//    int Brake = 0;
//    
//    // Read Log
//
//    if (GetLua.is_open())
//    {
//        
//        line = GetLastLine("D:/SteamLibrary/steamapps/common/GearBlocks/BepInEx/LogOutput.log");
//        while (line != "")
//        {
//            cout << line << endl;
//            if (line == "[Message:     Unity] Lua: Throttle = 0") {int Torque = 0;}
//            if (line == "[Message:     Unity] Lua: Throttle = 1") {int Torque = 100;}
//            this_thread::sleep_for(chrono::milliseconds(1));
//            line = GetLastLine("D:/SteamLibrary/steamapps/common/GearBlocks/BepInEx/LogOutput.log");
//        }
//    }
//    // Set Lua
//
//    return 0;
//}
//
////X-X will probrably hate this "code"...
//// i have no idea why "getline" is red, not the "if( line ="