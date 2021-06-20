#!/bin/bash
VALIDATE="validate"
if [ $2 != "1" ]
  then VALIDATE=""
fi
/steam-home/steam-cmd/steamcmd.sh +login anonymous +force_install_dir /steam-home/server/ +app_update $1 $VALIDATE +quit
shift 2
envsubst < /steam-home/default-configs/server-read.cfg.tpl > /steam-home/server/$1/cfg/server-read.cfg
cp -n /steam-home/default-configs/server-cvars.cfg /steam-home/server/$1/cfg/server-cvars.cfg
cp -n /steam-home/default-configs/myhost.txt /steam-home/server/$1/myhost.txt
cp -n /steam-home/default-configs/mymotd.txt /steam-home/server/$1/mymotd.txt
/steam-home/server/srcds_run -console -strictportbind -ip 0.0.0.0 -port 27015 -game $@ +servercfgfile server-read.cfg