#/bin/sh
set -e
SETTINGS=/etc/transmission-daemon/settings.json
LOCK=/install.LOCK

if [ ! -f ${LOCK} ]; then
    sed -i.bak -e "s/#rpc-password#/$PASSWORD/" $SETTINGS
	sed -i.bak -e "s/#rpc-username#/$USERNAME/" $SETTINGS
    echo "" > $LOCK
fi

/usr/bin/transmission-daemon --foreground --config-dir /etc/transmission-daemon
