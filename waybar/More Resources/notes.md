# Github notifications
config module:
```
"custom/github": {
    "format": "{} ",
    "return-type": "json",
    "interval": 60,
    "exec": "$HOME/.config/waybar/github.sh",
    "on-click": "xdg-open https://github.com/notifications"
}
```
## Notes
    1. Make sure jq is installed.
    2. Create notifications.token, a personal access token, with notifications in scope at https://github.com/settings/tokens.
    3. Create github.sh with the contents below, replacing username with your own.


```
#!/bin/bash

token=`cat ${HOME}/.config/github/notifications.token`
count=`curl -u username:${token} https://api.github.com/notifications | jq '. | length'`

if [[ "$count" != "0" ]]; then
    echo '{"text":'$count',"tooltip":"$tooltip","class":"$class"}'
fi
```