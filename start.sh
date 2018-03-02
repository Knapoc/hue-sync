#!/bin/sh

rm -rf /var/run
mkdir -p /var/run/dbus

dbus-uuidgen --ensure
dbus-daemon --system

avahi-daemon --daemonize --no-chroot

shairport-sync -m avahi -a "$AIRPLAY_NAME" -p "$HUE_SYNC_PORT" -o hue -- -b "$HUE_BRIDGE_IP" -i "$BRIDGE_ACCESS_IDENTIFIER" -l "$HUE_LAMP_COUNT"
