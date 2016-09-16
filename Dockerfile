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

# Create config folder
RUN mkdir /config

# Apply ownership
RUN chown transmission:transmission /config

USER transmission

# Ports and volumes
EXPOSE 9091
VOLUME ["/config", "/downloads"]

# Entrypoint
COPY ./entrypoint.sh /
WORKDIR /var/lib/transmission-daemon
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD /usr/bin/transmission-daemon --config-dir $HOME --logfile $HOME/main.log