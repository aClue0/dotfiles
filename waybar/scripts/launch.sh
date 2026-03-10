#!/bin/bash

# SETUP INSTRUCTIONS (for new machines):
# To bind this script to a keybind in Hyprland, open ~/.config/hypr/hyprland.conf
# and add the following line under your keybinds section:
#
#   bind = $mainMod, R, exec, ~/.config/waybar/scripts/launch.sh
#
# Make sure this script is executable:
#   chmod +x ~/.config/waybar/scripts/launch.sh

killall -9 waybar
waybar &

