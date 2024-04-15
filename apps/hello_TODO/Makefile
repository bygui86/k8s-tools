
# VARIABLES
CONTAINER_PREFIX = bygui86
TAG = v1.0.0

# CONFIG
.PHONY: help print-variables
.DEFAULT_GOAL = all


# ACTIONS

## build

build-bender :		## Build hello-bender container image
	cd hello-bender && \
	docker build . -t $(CONTAINER_PREFIX)/hello-bender:$(TAG)

build-fry :		## Build hello-fry container image
	cd hello-fry && \
	docker build . -t $(CONTAINER_PREFIX)/hello-fry:$(TAG)

build-zoidberg :		## Build hello-zoidberg container image
	cd hello-zoidberg && \
	docker build . -t $(CONTAINER_PREFIX)/hello-zoidberg:$(TAG)

build-bojack :		## Build hello-bojack container image
	cd hello-bojack && \
	docker build . -t $(CONTAINER_PREFIX)/hello-bojack:$(TAG)

build-matrix :		## Build hello-zoidberg container image
	cd hello-matrix && \
	docker build . -t $(CONTAINER_PREFIX)/hello-matrix:$(TAG)

build-all : build-bender build-fry build-zoidberg build-bojack build-matrix		## Build all hello-container images


## push

push-bender :		## Push hello-bender container image
	docker push $(CONTAINER_PREFIX)/hello-bender:$(TAG)

push-fry :		## Push hello-fry container image
	docker push $(CONTAINER_PREFIX)/hello-fry:$(TAG)

push-zoidberg :		## Push hello-zoidberg container image
	docker push $(CONTAINER_PREFIX)/hello-zoidberg:$(TAG)

push-bojack :		## Push hello-bojack container image
	docker push $(CONTAINER_PREFIX)/hello-bojack:$(TAG)

push-matrix :		## Push hello-matrix container image
	docker push $(CONTAINER_PREFIX)/hello-matrix:$(TAG)

push-all : push-bender push-fry push-zoidberg push-bojack push-matrix		## Push all hello-container images


## build && push

build-push-bender : build-bender push-bender		## Build & Push hello-whale container image

build-push-fry : build-fry push-fry		## Build & Push hello-fry container image

build-push-zoidberg : build-zoidberg push-zoidberg		## Build & Push hello-zoidberg container image

build-push-bojack : build-bojack push-bojack		## Build & Push hello-bojack container image

build-push-matrix : build-matrix push-matrix		## Build & Push hello-matrix container image

build-push-all : build-push-bender build-push-fry build-push-zoidberg build-push-bojack build-push-matrix		## Build & Push all hello-container images


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
	@echo "- - -"
	@echo "CONTAINER_VERSION: $(CONTAINER_VERSION)"
	@echo "REGISTRY_PREFIX: $(REGISTRY_PREFIX)"
	@echo "CONTAINER_TAG: $(CONTAINER_TAG)"
	@echo "- - -"
	@echo "AVAILABLE_EXCHANGES: $(AVAILABLE_EXCHANGES)"
	@echo "- - -"
	@echo "GIT_TAG_VERSION: input from user, format: v(major).(minor).(patch)"
	@echo ""
