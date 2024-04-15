#!/bin/bash
# IP checker


## low level configs
if [[ $(uname) == "Darwin" ]]; then   ### MacOS only
	shopt -s expand_aliases
	alias date="gdate"
fi


## variables

DEBUG_LOG_KEY="DEBUG"

### inputs defaults
HTTP_HEADER_X_FORWARDED_FOR_DEFAULT=""
ROUNDS_DEFAULT=1000
INTERVAL_DEFAULT=1   # seconds
TIMEOUT_DEFAULT=5   # seconds
DEBUG_LOG_DEFAULT=false
K8S_NODE_NAME_DEFAULT="node-name"
K8S_NODE_IP_DEFAULT="node-ip"
K8S_POD_NAME_DEFAULT="pod-name"
K8S_POD_IP_DEFAULT="pod-ip"


## functions

log() {
	LEVEL=$1
	MSG=$2
	if [[ $LEVEL != $DEBUG_LOG_KEY ]]; then
		echo "$(date +%Y-%m-%dT%H:%M:%S) | $LEVEL | $MSG"
	else
		if $DEBUG_LOG; then   # WARN: not using square brackets ('[..]') as env-var is boolean
			echo "$(date +%Y-%m-%dT%H:%M:%S) | $LEVEL | $MSG"
		fi
	fi
}

check_command() {
	if [ ! -n $(command -v $1) ]; then
		log "ERROR" "Command '$1' not found - exit!"
		usage
		exit 1
	fi
}

check_env_var() {
	if [ -z "$2" ]; then
		log "ERROR" "Missing '$1' - exit!"
		usage
		exit 1
	fi
}

usage() {
	cat <<EOF

Usage: ip-checker [-h]

IP-checker makes some requests to a website (e.g. http://httpbin.org/ip) to verify the origin IP address.

Environment variables:
    HTTP_CHECK_URL                URL to verify the origin IP with 'http://' prefix
    HTTP_HEADER_X_FORWARDED_FOR   (optional) HTTP 'X-Forwarded-For' header; default '$HTTP_HEADER_X_FORWARDED_FOR_DEFAULT'
    ROUNDS                        (optional) How many times the IP-checker performs the request; default '$ROUNDS_DEFAULT'
    INTERVAL                      (optional) Interval in seconds between a request and the next one; default '$INTERVAL_DEFAULT'
    TIMEOUT                       (optional) Timeout in seconds for a request; default '$TIMEOUT_DEFAULT'
    DEBUG_LOG                     (optional) Enable debug logging; default '$DEBUG_LOG_DEFAULT'; available values: true, false
    K8S_NODE_NAME                 (optional) Kubernetes Node name on which the Pod runs; default '$K8S_NODE_NAME_DEFAULT'
    K8S_NODE_IP                   (optional) Kubernetes Node IP on which the Pod runs; default '$K8S_NODE_IP_DEFAULT'
    K8S_POD_NAME                  (optional) Kubernetes Pod name; default '$K8S_POD_NAME_DEFAULT'
    K8S_POD_IP                    (optional) Kubernetes Pod IP; default '$K8S_POD_IP_DEFAULT'

Available options:
    -h, --help      Print this help and exit

Dependencies:
    curl            Linux curl

EOF
	exit 1
}

parse_params() {
	while :; do
		case "${1-}" in
		-h | --help) usage ;;
		*) break ;;
		esac
		shift
	done
	return 0
}


## actions

### help
parse_params "$@"

### log info
log "INFO" "Start IP-checker"

### commands
log "INFO" "Check commands"
check_command "curl"

### env vars
log "INFO" "Check environment variables"
check_env_var "HTTP_CHECK_URL" $HTTP_CHECK_URL

### set defaults
if [ -z "$DEBUG_LOG" ]; then
	# log "$DEBUG_LOG_KEY" "Missing 'DEBUG_LOG' - Use '$DEBUG_LOG_DEFAULT' as default"
	DEBUG_LOG=$DEBUG_LOG_DEFAULT
fi

if [ -z "$HTTP_HEADER_X_FORWARDED_FOR" ]; then
	log "$DEBUG_LOG_KEY" "Missing 'HTTP_HEADER_X_FORWARDED_FOR' - Use '$HTTP_HEADER_X_FORWARDED_FOR_DEFAULT' as default"
	HTTP_HEADER_X_FORWARDED_FOR=$HTTP_HEADER_X_FORWARDED_FOR_DEFAULT
fi

if [ -z "$ROUNDS" ]; then
	log "$DEBUG_LOG_KEY" "Missing 'ROUNDS' - Use '$ROUNDS_DEFAULT' as default"
	ROUNDS=$ROUNDS_DEFAULT
fi

if [ -z "$INTERVAL" ]; then
	log "$DEBUG_LOG_KEY" "Missing 'INTERVAL' - Use '$INTERVAL_DEFAULT' as default"
	INTERVAL=$INTERVAL_DEFAULT
fi

if [ -z "$TIMEOUT" ]; then
	log "$DEBUG_LOG_KEY" "Missing 'TIMEOUT' - Use '$TIMEOUT_DEFAULT' as default"
	TIMEOUT=$TIMEOUT_DEFAULT
fi

if [ -z "$K8S_NODE_NAME" ]; then
	log "$DEBUG_LOG_KEY" "Missing 'K8S_NODE_NAME' - Use '$K8S_NODE_NAME_DEFAULT' as default"
	K8S_NODE_NAME=$K8S_NODE_NAME_DEFAULT
fi

if [ -z "$K8S_NODE_IP" ]; then
	log "$DEBUG_LOG_KEY" "Missing 'K8S_NODE_IP' - Use '$K8S_NODE_IP_DEFAULT' as default"
	K8S_NODE_IP=$K8S_NODE_IP_DEFAULT
fi

if [ -z "$K8S_POD_NAME" ]; then
	log "$DEBUG_LOG_KEY" "Missing 'K8S_POD_NAME' - Use '$K8S_POD_NAME_DEFAULT' as default"
	K8S_POD_NAME=$K8S_POD_NAME_DEFAULT
fi

if [ -z "$K8S_POD_IP" ]; then
	log "$DEBUG_LOG_KEY" "Missing 'K8S_POD_IP' - Use '$K8S_POD_IP_DEFAULT' as default"
	K8S_POD_IP=$K8S_POD_IP_DEFAULT
fi

### log debug
log "INFO" "Debug log: $DEBUG_LOG"
log "INFO" "HTTP check URL: $HTTP_CHECK_URL"
log "INFO" "HTTP 'X-Forwarded-For' header: $HTTP_HEADER_X_FORWARDED_FOR"
log "INFO" "Rounds: $ROUNDS"
log "INFO" "Interval: $INTERVAL (sec)"
log "INFO" "Timeout: $TIMEOUT (sec)"
log "INFO" "K8s node name: $K8S_NODE_NAME"
log "INFO" "K8s node IP: $K8S_NODE_IP"
log "INFO" "K8s pod name: $K8S_POD_NAME"
log "INFO" "K8s pod IP: $K8S_POD_IP"

### request loop

# WARN: Brace expansion {x..y} is performed before other expansions
# for round in {1..$ROUNDS} ; do
# 	...
# done

# WARN: "sh" equivalent loop syntax
# i=1
# while [ "$i" -le $ROUNDS ]; do
# 	...
# done

for (( round=1; round<=$ROUNDS; round++ )); do
	log "$DEBUG_LOG_KEY" "Round: $round"

	# sec_start=$(date +%s)   # "seconds" precision
	mil_start=$(date +%s%3N)   # "milliseconds" precision
	# micro_start=$(date +%s%6N)   # "microseconds" precision
	nano_start=$(date +%s%N)   # "nanoseconds" precision

	if [ -z "$HTTP_HEADER_X_FORWARDED_FOR" ]; then
		SOURCE_IP=$(curl -s -X GET $HTTP_CHECK_URL --connect-timeout $TIMEOUT --max-time $TIMEOUT)
	else
		SOURCE_IP=$(curl -s -X GET $HTTP_CHECK_URL -H "X-Forwarded-For: $HTTP_HEADER_X_FORWARDED_FOR" --connect-timeout $TIMEOUT --max-time $TIMEOUT)
	fi
	# log "$DEBUG_LOG_KEY" "Source IP: '$SOURCE_IP'"   # WARN: this interfeers with following check "$? -ne 0"

	if [ $? -ne 0 ]; then
		level="ERROR"
		msg="[$K8S_NODE_NAME|$K8S_NODE_IP|$K8S_POD_NAME|$K8S_POD_IP] Source IP: UNKNOWN - Request failed"
	else
		level="INFO"
		msg="[$K8S_NODE_NAME|$K8S_NODE_IP|$K8S_POD_NAME|$K8S_POD_IP] Source IP: '$SOURCE_IP'"
	fi

	# sec_end=$(date +%s)   # "seconds" precision
	mil_end=$(date +%s%3N)   # "milliseconds" precision
	# micro_end=$(date +%s%6N)   # "microseconds" precision
	nano_end=$(date +%s%N)   # "nanoseconds" precision

	# msg="$msg - Execution time: '$(expr $sec_end - $sec_start) sec' / '$(expr $mil_end - $mil_start) millis' / '$(expr $micro_end - $micro_start) micros' / '$(expr $nano_end - $nano_start) nanos'"
	msg="$msg - Execution time: '$(expr $mil_end - $mil_start) millis' / '$(expr $nano_end - $nano_start) nanos'"

	log "$level" "$msg"

	sleep $INTERVAL
done

### log info
log "INFO" "IP-checker completed"
exit 0
