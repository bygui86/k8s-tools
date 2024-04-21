
# base image
## 12.5-slim/bookworm-slim - amd64
FROM debian:12.5-slim@sha256:3d5df92588469a4c503adbead0e4129ef3f88e223954011c2169073897547cac

# install packages
## update and upgrade
RUN apt-get update -qqy && \
	apt-get upgrade -qqy
## install base
### packages required by other tools:
###   - gcloud: apt-transport-https, ca-certificates, gnupg, curl
###   - terraform: software-properties-common, gnupg2
RUN apt-get install -qqy \
		apt-transport-https \
		ca-certificates \
		gnupg \
		software-properties-common \
		gnupg2 \
		curl \
		wget
## install general
RUN apt-get install -qqy \
		jq \
		yq \
		vim \
		nano \
		stress
## install networking
RUN apt-get install -qqy \
		httpie \
		openssh-client \
		netcat-openbsd \
		net-tools \
		iptables \
		tcpdump \
		nmap
## cleanup
RUN apt-get autoclean && \
	rm -rf /var/lib/apt/lists/*

# install gcloud
# https://cloud.google.com/sdk/docs/install#deb
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
	apt-get update -y && \
	apt-get install -y google-cloud-cli && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /.config/gcloud && \
	chown -R 1001 /.config/gcloud && \
	gcloud version

# install kubectl
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
	echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check && \
	install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
	kubectl version --client

# set current dir
WORKDIR /usr/local/bin

# install kustomize
# https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/
# RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash && \
	kustomize version

# install helm
# https://helm.sh/docs/intro/install/#from-script
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash && \
	helm version

# install terraform
# https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
	apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
	apt-get update -qqy && \
	apt-get install -qqy terraform && \
	apt-get autoclean && \
	rm -rf /var/lib/apt/lists/* && \
	terraform --version

# set user
USER 1001

# run
# ENTRYPOINT ["/bin/sh", "-c", "while :; do echo 'I will go to sleep for an hour, see ya later...'; sleep 3600; done"]
