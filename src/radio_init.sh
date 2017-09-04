#!/bin/bash
streamserver="fr1.net.litzinetz.de"

/usr/bin/play ../audio/hello.wav >/dev/null 2>&1
/usr/bin/play ../audio/checking_onemoment.wav >/dev/null 2>&1

# loop forever
while true
do
	# conn check
	/usr/bin/curl -sSf --connect-timeout 10 --max-time 14 $streamserver >/dev/null 2>&1
	if [ $? = 0 ]; then
		# check ok
		/usr/bin/play ../audio/readytogo.wav >/dev/null 2>&1
		/usr/bin/mplayer -prefer-ipv4 http://$streamserver/live </dev/null >/dev/null 2>&1
	else
		# check failed
		/usr/bin/play ../audio/noconn.wav >/dev/null 2>&1
		/bin/sleep 30
	fi
done