#!/bin/sh
# TCP pinger

echo "Start TCP pinger to ${HOST}:${PORT}"
while [ true ]
do
	nc -zv ${HOST} ${PORT}
	sleep 1
done
echo "TCP pinger terminated"
