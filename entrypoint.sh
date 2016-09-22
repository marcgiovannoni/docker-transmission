#!/bin/sh

# Copy default settings.json if not present
if [ ! -f /config/settings.json ]; then
    echo "Copy default settings.json to /config"
    cp /settings.json /config/
fi

echo "Starting tramission-daemon..."
exec "$@"
