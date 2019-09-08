FROM jenkins/jnlp-slave
USER root

# install ansible, awscli and jq
RUN apt update && apt install python-pip jq -y && pip install ansible awscli

# install docker
RUN curl -fsSL https://get.docker.com | bash

# install gcloud sdk
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

# install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl && mv ./kubectl /usr/local/bin/

# install helm
RUN curl -L https://git.io/get_helm.sh | bash

USER jenkins
