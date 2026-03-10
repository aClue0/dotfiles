#!/bin/bash

# Load token
token=$(cat "${HOME}/.config/github/notifications.token")

# Fetch notifications count
count=$(curl -s -u aClue0:"$token" https://api.github.com/notifications | jq 'length')

# Only show if there are notifications
if [[ "$count" != "0" ]]; then
    echo "{\"text\":\"$count \",\"tooltip\":\"$count GitHub notifications\",\"class\":\"alert\"}"
fi
