FROM longjunyu/theforest-base:latest

LABEL maintainer="Junyu Long"

ENV TZ=Asia/Shanghai \
    USER_ID=1000 \
    GROUP_ID=1000

VOLUME ["/data/config/saves", "/data/config/config.cfg"]

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone
	
COPY scripts/* /data/scripts

RUN chmod -R 755 /data/scripts

CMD ["/data/scripts/entry"]
