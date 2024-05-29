
# k8s-tools

A collection of tools useful to work on/with Kubernetes

## List of tools

- [x] busybox
- [x] ubuntu
- [x] debian
- [x] gcloud
- [x] kubectl
- [x] kubectl + jq + yq
- [x] terraform
- [x] k8s-army-knife
- [x] netshoot
- [x] git sync sidecar
- [x] script executor
- [x] echo server
- [x] tcp caller/listener
- [x] storage filler
- [x] http server + client
- [x] grpc server + client
- [x] stress resources
- [x] network bandwidth (iperf3)

---

## Container images references

### gcloud

- gcr.io/google.com/cloudsdktool/cloud-sdk
	- <MAJOR>.0.0
	- <MAJOR>.0.0-slim
	- <MAJOR>.0.0-alpine

### k8s

- bygui86/kubectl
	- only latest of last 3 minor versions

- quay.io/codefresh/kubectl
	- only latest of last 3 minor versions

- rancher/kubectl
	- https://github.com/rancher/kubectl
	- pure kubectl, no shell to execute scripts

- bygui86/k8s-army-knife:1.1.0

### default tools

- busybox
	- 1.36.1-uclibc (buildroot)
	- 1.36.1-musl (alpine)
	- 1.36.1-glibc (debian)

- ubuntu:24.04

- debian:12.5-slim

- hashicorp/terraform:1.8

- hashicorp/http-echo:1.0
	- https://hub.docker.com/r/hashicorp/http-echo

### networking

- nicolaka/netshoot:v0.12
	- https://github.com/nicolaka/netshoot

- cagedata/iperf3:3.10.1
	- https://medium.com/@muthanagavamsi/kubernetes-network-bandwidth-test-between-2-pods-a01a154ba07f
	- https://hub.docker.com/r/cagedata/iperf3

### HTTP

- bygui86/http-client:v1.0.0

- bygui86/http-server:v1.0.0

### gRPC

- bygui86/grpc-client:v1.0.0

- bygui86/grpc-server:v1.0.0

### custom applications/scripts/containers

- https://github.com/ColinIanKing/stress-ng
