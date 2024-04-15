
# amd64 base image
## amd64
FROM alpine:3.19.1@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

# install packages
## PLEASE NOTE: coreutils is required by "date" command
RUN apk update --no-cache && \
	apk add --no-cache bash \
		ca-certificates \
		coreutils \
		curl \
		httpie \
		jq \
		yq \
		netcat-openbsd \
		net-tools \
		iptables \
		tcpdump && \
	rm -rf /var/cache/apk/*

# install kubectl
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
	mv kubectl /usr/local/bin/kubectl && \
	chmod +x /usr/local/bin/kubectl

# set current dir
WORKDIR /usr/local/bin

# set user
USER 1001

# run
ENTRYPOINT ["/bin/sh", "-c", "while :; do echo 'I will go to sleep for an hour, see ya later...'; sleep 3600; done"]
