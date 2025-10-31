#include <iostream>
#include <fstream>
#include <string>
#include <chrono>
#include <thread>

using namespace std;

int main()
{
  ifstream SetRPM;
  string line;
  SetRPM.open("D:/SteamLibrary/steamapps/common/GearBlocks/BepInEx/LogOutput.log");
  if (SetRPM.is_open())
  {
    while (getline(SetRPM, line))
    {
      cout << line << endl;
      std::this_thread::sleep_for(std::chrono::milliseconds(7));
    }
    SetRPM.close();
  }
  // SetRPM << "local ESOutput = {}/n/nESOutput.RPM = 50/nESOutput.Torque = 50/nESOutput.Brake = 0/nreturn ESOutput";
  // SetRPM.close();

  return 0;
}