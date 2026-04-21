#!/usr/bin/env bash

# 1. Ask all windows to close gracefully
HYPRLAND_CLIENTS=$(hyprctl clients -j | jq -r '.[].address')

for client in $HYPRLAND_CLIENTS; do
    hyprctl dispatch closewindow address:"$client"
done

# 2. Give apps a moment to save data, cookies, and close
sleep 2

# 3. Check if any windows refused to close (e.g., an unsaved document prompt)
REMAINING_CLIENTS=$(hyprctl clients -j | jq '. | length')

if [ "$REMAINING_CLIENTS" -gt 0 ]; then
    # If apps are still open, cancel the logout and notify you
    notify-send "Logout Aborted" "Some apps are waiting for you to save your work."
    exit 1
fi

# 4. If everything is closed nicely, safely exit Hyprland to return to GDM
hyprctl dispatch exit
