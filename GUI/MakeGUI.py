"""
This program uses pyuic to transform the "xxx.ui" file into "xxx.py" file.
"""
import subprocess
from os import path

directory = path.dirname(path.abspath(__file__))

subprocess.call(["pyuic5", path.join(directory, "ui_files\\GUI.ui"), ">",
                 path.join(directory, "uipy\\GUI.py")], shell=True)
