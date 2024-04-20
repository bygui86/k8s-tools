#!/bin/sh
# TCP caller

echo "Start TCP caller to ${HOST}:${PORT} with message ${MSG}"
while [ true ]
do
	echo ${MSG} | nc -v -q 0 ${HOST} ${PORT}
	sleep 1
done
echo "TCP caller terminated"
