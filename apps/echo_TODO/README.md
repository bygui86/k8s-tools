
# echo

## description

Kind of reverse-proxy written in Golang to echoes all messages received through exposed REST API.

## ports

- 7001		rest api
- 7090		rest api for kubernetes probes

## rest apis

- port 7001
  - GET /echo			echo default message "Hello Wolrd"
  - GET /echo/{msg}		echo back incoming message

- port 7090
  - GET /live		kubernetes liveness probe
  - GET /ready		kubernetes readyness probe
