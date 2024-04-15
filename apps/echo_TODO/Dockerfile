
FROM golang:1.12-stretch AS gobuilder

ENV CGO_ENABLED=0
ENV GOOS=linux

WORKDIR /go/src/github.com/bygui86/k8s-tools/echo

COPY . .

RUN ["/bin/bash", "-c", "go get -v -d ."]

RUN go build -a -installsuffix cgo -o /bin/app .

# ---

FROM alpine

RUN apk update --no-cache
RUN apk add --no-cache bash
RUN apk add --no-cache curl

WORKDIR /usr/bin/

EXPOSE 7001
EXPOSE 7090

USER 1001

ENTRYPOINT "/usr/bin/app"
