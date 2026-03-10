#!/bin/bash

# SETUP INSTRUCTIONS :
# bind this script to a keybind in Hyprland, or the TWM you use, open ~/.config/hypr/hyprland.conf
# and add the following line under your keybinds section:
#
#   bind = $mainMod, R, exec, ~/.config/waybar/scripts/launch.sh
#
# Make sure this script is executable:
#   chmod +x ~/.config/waybar/scripts/launch.sh
# Now, when you press the specified key combination (e.g., Super + R), it will execute this script,
# which will kill any existing Waybar instances and start a new one, so you can see the 
# changes you made to the configuration file without needing to restart your entire session.

killall -9 waybar
waybar &

