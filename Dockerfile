FROM debian:jessie

# global environment settings
ENV HOME="/config" \
    DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm"

RUN apt-get update && \
# Transmission user
    useradd --system --uid 842 -M --shell /usr/sbin/nologin transmission && \
# Install transmission
    apt-get install -y \
        transmission-daemon

USER transmission

# Ports and volumes
EXPOSE 9091
VOLUME ["/config", "/downloads"]

# Entrypoint
COPY ./entrypoint.sh transmission/settings.json /
WORKDIR /var/lib/transmission-daemon
ENTRYPOINT ["/entrypoint.sh"]
CMD /usr/bin/transmission-daemon -f --config-dir $HOME --logfile $HOME/main.log
