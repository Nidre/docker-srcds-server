FROM ubuntu:18.04

# Prepare the system
# for l4d2 & tf2
RUN dpkg --add-architecture i386;
RUN apt-get update && \
    apt-get install -y nano curl gdb gettext-base lib32gcc1 lib32tinfo5 && \
    apt-get install -y libc6:i386 lib32z1 && \
    apt-get install -y mailutils postfix wget file bzip2 gzip unzip bsdmainutils python util-linux tmux libstdc++6 libstdc++6:i386 libcurl4-gnutls-dev:i386 && \
    apt-get autoclean && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add a separate user
RUN useradd --create-home --home-dir /steam-home --shell /bin/bash --uid 1000 steam \
    && chown -R steam /steam-home

# Switch to that user
USER steam

# Install SteamCMD (https://developer.valvesoftware.com/wiki/SteamCMD)
RUN mkdir /steam-home/steam-cmd && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - -C /steam-home/steam-cmd
# Initialize SteamCMD
RUN /steam-home/steam-cmd/steamcmd.sh +quit

# Support for 64-bit systems
# https://www.gehaxelt.in/blog/cs-go-missing-steam-slash-sdk32-slash-steamclient-dot-so/
RUN ln -s /steam-home/steam-cmd/linux32/ /steam-home/.steam/sdk32

#Copy entrypoint & default-configs
COPY files/entrypoint.sh /steam-home/entrypoint.sh
COPY files/server-read.cfg.tpl /steam-home/default-configs/server-read.cfg.tpl
COPY files/server-cvars.cfg /steam-home/default-configs/server-cvars.cfg
COPY files/myhost.txt /steam-home/default-configs/myhost.txt
COPY files/mymotd.txt /steam-home/default-configs/mymotd.txt

# Expose the ports
## Game transmission, pings and RCON
EXPOSE 27015 27015/udp
## SourceTV transmission
EXPOSE 27020/udp
## Client Port
EXPOSE 27005/udp

ENV GAME_ID="222860"
ENV GAME_NAME="left4dead2"
ENV GAME_VALIDATE="0"
ENV START_ARG="-timeout 10 -tickrate 100 -maxplayers 32 +sv_clockcorrection_msecs 25 +map c2m1_highway"
ENV SV_HOSTNAME="L4D2 Server"
ENV SV_RCON_PASSWORD="!change-me!P5as2S9sXw2Zor1d"
ENV SV_STEAMGROUP="0"
ENV SV_STEAMGROUP_EXCLUSIVE="1"
ENV SV_SEARCH_KEY="SomeKey"
ENV FILENAME_CVARS="server-cvars.cfg"
ENV FILENAME_MOTD="mymotd.txt"
ENV FILENAME_HOST="myhost.txt"

ENTRYPOINT ["sh", "-c", "/steam-home/entrypoint.sh $GAME_ID $GAME_VALIDATE $GAME_NAME $START_ARG"]
