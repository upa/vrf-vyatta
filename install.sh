#!/bin/bash

cp -r bin /opt/vyatta/
cp -r sbin /opt/vyatta/

cp -r vyatta-op /opt/vyatta/share/
cp -r vyatta-cfg /opt/vyatta/share/

if [ -z "`grep games /etc/default/vyatta`" ]; then
	echo "declare -x PATH=/usr/bin:/usr/local/bin:/bin:/usr/local/games:/usr/games"
fi
