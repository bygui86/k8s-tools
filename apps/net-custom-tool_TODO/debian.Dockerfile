
# base image
## 12.5-slim/bookworm-slim - amd64
FROM debian:12.5-slim@sha256:3d5df92588469a4c503adbead0e4129ef3f88e223954011c2169073897547cac

# install packages
RUN apt-get update -qqy && \
	apt-get upgrade -qqy && \
	apt-get install -qqy \
		ca-certificates \
		curl \
		httpie \
		jq \
		yq \
		netcat-openbsd \
		net-tools \
		iptables \
		tcpdump && \
	apt-get autoclean && \
	rm -rf /var/lib/apt/lists/*

# set current dir
WORKDIR /usr/local/bin

# set user
USER 1001

# run
ENTRYPOINT ["/bin/sh", "-c", "while :; do echo 'I will go to sleep for an hour, see ya later...'; sleep 3600; done"]
