FROM ubuntu:18.04

LABEL maintainer="Junyu Long"

ENV TIMEZONE=Asia/Shanghai \
    PUID=0 \
    GUID=0

EXPOSE 8766/tcp 8766/udp 27015/tcp 27015/udp 27016/tcp 27016/udp

VOLUME [ "/games/data/theforest/saves", "/games/data/theforest/config"]

RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo $TIMEZONE > /etc/timezone \
    && dpkg --add-architecture i386 \
    && apt update \
    && apt dist-upgrade -y \
    && apt install -y wine-stable winbind xvfb wget gnupg \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir -p /steamcmd \
    && cd /steamcmd \
    && wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" -O steamcmd.tar.gz \
    && tar zxvf steamcmd.tar.gz \
    && rm steamcmd.tar.gz \
    && ./steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir +login anonymous /games/app/theforest +app_update 556450 validate +quit

CMD xvfb-run --auto-servernum --server-args='-screen 0 640x480x24:32' wine /games/app/theforest/TheForestDedicatedServer.exe -batchmode -nographics -savefolderpath /games/data/theforest/saves/ -configfilepath /games/data/theforest/config/config.cfg
