import os, json
import tkinter as tk
from tkinter import filedialog

root = tk.Tk()
root.withdraw()

Gearblocks_Path = ""
ES2D_Path = ""

def learn_config():
    global Gearblocks_Path
    Gearblocks_Path = filedialog.askopenfilename()

def load_config():
    global Gearblocks_Path, ES2D_Path
    config_file = open("config.json")
    content = json.load(config_file)
    config_file.close()
    Gearblocks_Path = content['GB_Path']
    ES2D_Path = content['ES2D_Path']
    if (not Gearblocks_Path) or (not ES2D_Path):
        learn_config()

if os.path.exists("config.json"):
    load_config()
else:
    config_file = open("config.json", "w")
    learn_config()
    content = {
        "GB_Path":Gearblocks_Path,
        "ES2D_Path":ES2D_Path
    }
    json.dump(content, config_file)


values_template = """local vals = {}
vals.rpm = %i
vals.trq = %i
return vals
"""

def write_wheel(rpm:int, torque: int):
    valuesfile = open("values.lua","w")
    valuesfile.write(values_template.format(rpm, torque))

