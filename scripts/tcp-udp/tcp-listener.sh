#!/bin/sh
# TCP listener

echo "Start TCP listener on port ${PORT}"
while [ true ]
do
	echo "Open new connection"
	# macos
	# nc -v -k -l ${PORT}
	# linux
	nc -v -k -l -p ${PORT}
	echo "Connection closed by client"
	sleep 1
done
echo "TCP listener terminated"
