#!/usr/bin/env bash

# 1. Initial Notification (Native Progress Bar at 0%)
notify-send -h string:x-canonical-private-synchronous:sys-power -h int:value:0 -u normal "System Shutdown" "Initiating shutdown sequence..."

# 2. Ask all windows to close gracefully
HYPRLAND_CLIENTS=$(hyprctl clients -j | jq -r '.[].address')
for client in $HYPRLAND_CLIENTS; do
    hyprctl dispatch closewindow address:"$client"
done

# 3. Update the bar while we wait (Native Progress Bar at 30%)
sleep 0.5
notify-send -h string:x-canonical-private-synchronous:sys-power -h int:value:30 -u normal "System Shutdown" "Saving app data & cookies..."
sleep 1

# 4. Waiting for tasks (Native Progress Bar at 70%)
notify-send -h string:x-canonical-private-synchronous:sys-power -h int:value:70 -u normal "System Shutdown" "Waiting for background tasks..."
sleep 1

# 5. Safety Check: Did any apps refuse to close?
REMAINING_CLIENTS=$(hyprctl clients -j | jq '. | length')
if [ "$REMAINING_CLIENTS" -gt 0 ]; then
    # We drop the progress bar and send a critical alert
    notify-send -h string:x-canonical-private-synchronous:sys-power -u critical "Shutdown Aborted" "Some apps refused to close. Please save your work!"
    exit 1
fi

# 6. Final message (Native Progress Bar at 100%)
notify-send -h string:x-canonical-private-synchronous:sys-power -h int:value:100 -u normal "System Shutdown" "All clear. Goodbye!"
sleep 0.8

# 7. Actually shut down the computer
systemctl poweroff
