#include <iostream>
#include <fstream>
#include <string>
#include <chrono>
#include <thread>

using namespace std;

std::string read_last_line(const std::string& filename) {
    std::ifstream file(filename, std::ios::ate | std::ios::binary);
    if (!file.is_open()) return "";

    std::streampos file_size = file.tellg();
    if (file_size == 0) return "";  // empty file

    std::string line;
    char ch;

    // Start from the end and move backwards until you find a newline
    for (std::streamoff i = 1; i <= file_size; ++i) {
        file.seekg(-i, std::ios::end);
        file.get(ch);

        if (ch == '\n' && i != 1) {
            break; // stop at the newline before the last line
        }

        line.insert(line.begin(), ch);
    }
    return line;
}


int main() {

    ifstream GetLua;
    ofstream SetLua;
    string line;

    srand(time(0));

    int RPM = 1000;
    int Torque = 0;
    int Brake = 0;
    int Ping = rand() % 101;

    SetLua.open("C:/Users/Owner/AppData/LocalLow/SmashHammer Games/GearBlocks/ScriptMods/ES-Linker-GearBlocks/ESOutput.lua");
    SetLua << "local ESOutput = {}\n\nESOutput.RPM = ";
    SetLua << to_string(RPM);
    SetLua << "\nESOutput.Torque = ";
    SetLua << to_string(Torque);
    SetLua << "\nESOutput.Brake = ";
    SetLua << to_string(Brake);
    SetLua << "\nESOutput.Ping = ";
    SetLua << to_string(Ping);
    SetLua << "\nreturn ESOutput";
    SetLua.close();

    std::this_thread::sleep_for(std::chrono::milliseconds(1800));

    std::string last = read_last_line("D:/SteamLibrary/steamapps/common/GearBlocks/BepInEx/LogOutput.log");
    std::cout << last << "\n";
    return 0;
}