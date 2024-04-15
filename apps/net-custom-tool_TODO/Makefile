
# VARIABLES
# -


# CONFIG
.PHONY: help print-variables
.DEFAULT_GOAL := help


# ACTIONS

build-alpine :		## build alpine-based container image
	docker build . -f alpine.Dockerfile --tag ip-checker:alpine

build-debian :		## build debian-based container image
	docker build . -f debian.Dockerfile --tag ip-checker:debian

build-ubuntu :		## build alpine-based container image
	docker build . -f ubuntu.Dockerfile --tag ip-checker:ubuntu

build : build-alpine		## build container image

## run

run-alpine :		## run alpine-based container
	docker run -d --name ip-checker-alpine ip-checker:alpine

run-debian :		## run debian-based container
	docker run -d --name ip-checker-debian ip-checker:debian

run-ubuntu :		## run ubuntu-based container
	docker run -d --name ip-checker-ubuntu ip-checker:ubuntu

run : run-alpine		## run container

stop-alpine :		## stop alpine-based container
	docker container stop ip-checker-alpine -t 1
	docker container rm ip-checker-alpine

stop-debian :		## stop debian-based container
	docker container stop ip-checker-debian -t 1
	docker container rm ip-checker-debian

stop-ubuntu :		## stop ubuntu-based container
	docker container stop ip-checker-ubuntu -t 1
	docker container rm ip-checker-ubuntu

stop : stop-alpine		## stop container

## ssh

ssh-alpine :		## ssh into alpine-based container
	docker exec -ti ip-checker-alpine sh

ssh-debian :		## ssh into debian-based container
	docker exec -ti ip-checker-debian sh

ssh-ubuntu :		## ssh into ubuntu-based container
	docker exec -ti ip-checker-ubuntu sh

ssh : ssh-alpine		## ssh into container

## helpers

help :		## Help
	@echo ""
	@echo "*** \033[33mMakefile help\033[0m ***"
	@echo ""
	@echo "Targets list:"
	@grep -E '^[a-zA-Z_-]+ :.*?## .*$$' $(MAKEFILE_LIST) | sort -k 1,1 | awk 'BEGIN {FS = ":.*?## "}; {printf "\t\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ""

print-variables :		## Print variables values
	@echo ""
	@echo "*** \033[33mMakefile variables\033[0m ***"
	@echo ""
	@echo "- - - makefile - - -"
	@echo "MAKE: $(MAKE)"
	@echo "MAKEFILES: $(MAKEFILES)"
	@echo "MAKEFILE_LIST: $(MAKEFILE_LIST)"
	@echo ""
