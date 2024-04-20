
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
- [ ] `TBD` memory stress
- [ ] `TBD` storage filler
- [ ] `TBD` http server + client
- [ ] `TBD` grpc server + client

---

## Container images references

### gcloud

- gcr.io/google.com/cloudsdktool/cloud-sdk
	- <MAJOR>.0.0
	- <MAJOR>.0.0-slim
	- <MAJOR>.0.0-alpine

### kubectl

- bygui86/kubectl
	- only latest of last 3 minor versions

- quay.io/codefresh/kubectl
	- only latest of last 3 minor versions

- rancher/kubectl
	- https://github.com/rancher/kubectl
	- pure kubectl, no shell to execute scripts

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

- nicolaka/netshoot
	- https://github.com/nicolaka/netshoot

### custom applications/scripts/containers

- bygui86/k8s-army-knife
- k8s-pod-logs-checker
- script-executor
- storage-filler
- tcp-caller-listener
- https://github.com/ColinIanKing/stress-ng
