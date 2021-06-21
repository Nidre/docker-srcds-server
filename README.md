# docker-srcds-server

## Simple run:
> docker run -n srcds-server -v /steam-home/server/your-game-name:/new-path nidre/srcds-server

or 

> docker run -n srcds-server -v /steam-home/server:/new-path nidre/srcds-server

## Environment variables:
**ENVNAME**="default value" *- description*

* **TZ**="Europe/Moscow"
* **GAME_ID**="222860"
* **GAME_NAME**="left4dead2"
* **GAME_VALIDATE**="0" *- validate update on startup (1 - to enable)*
* **START_ARG**="-timeout 10 -tickrate 100 -maxplayers 32 +sv_clockcorrection_msecs 25 +map c2m1_highway"
* **SV_HOSTNAME**="L4D2 Server"
* **SV_RCON_PASSWORD**="!change-me!P5as2S9sXw2Zor1d"
* **SV_STEAMGROUP**="0"
* **SV_STEAMGROUP_EXCLUSIVE**="1"
* **SV_SEARCH_KEY**="SomeKey"
* **FILENAME_CVARS**="server-cvars.cfg"
* **FILENAME_MOTD**="mymotd.txt"
* **FILENAME_HOST**="myhost.txt"

## Server config:
You can change server config in **your-game-name/cfg/server-cvars.cfg** file.

You can change server motd & host in **your-game-name/mymotd.txt** & **your-game-name/myhost.txt** files.
