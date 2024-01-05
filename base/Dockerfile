FROM steamcmd/steamcmd:ubuntu-18

LABEL maintainer="Junyu Long"

ENV TZ=Asia/Shanghai \
    USER_ID=1000 \
    GROUP_ID=1000

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && dpkg --add-architecture i386 \
    && DEBIAN_FRONTEND=noninteractive apt update \
    && DEBIAN_FRONTEND=noninteractive apt dist-upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt install -y wine-stable winbind xvfb wget gnupg \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir -p /data/scripts
	
COPY scripts/* /data/scripts

RUN chmod -R 755 /data/scripts

RUN source /data/scripts/server; update_server

ENTRYPOINT [""]

CMD ["/data/scripts/entry"]
