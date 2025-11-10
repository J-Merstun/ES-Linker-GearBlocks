# Engine Simulator for Gearblocks
<br>

This repository seeks to implement a script mod

To Do:

- Find a way for GearBlocks to talk to Engine Simulator without taking a 2 second delay
    - Curent theory is to use sockets via a BepinEX plugin or have a BepinEX plugin listen for lines in the Loh and save them to a file faster then the Log.txt can save (2 second delay on the log.txt)

- Get readouts from Engine Sim of Engine Torque and RPM
    - Leads listed in: Notes.txt


Curently have some C++ code talking to Gearblocks via ESLinker.lua by updaying that file for Main.Lua to read, if a socket is sucsessfull it would likely to be more efficent to have the BepinEX Plugin talk to Engine Sim, Depedning on the complexity it might be effectivly to have the controller made in lua as its simple to undersand and everyone is use to using Script Mods. Data can still be sent to the plugin via the Log.
