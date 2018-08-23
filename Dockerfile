FROM docker:latest
RUN apk add --no-cache python2 bash curl openssl py-setuptools git

RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-213.0.0-linux-x86_64.tar.gz | tar -xzf -
RUN /google-cloud-sdk/install.sh
ENV PATH=/google-cloud-sdk/bin:$PATH
RUN gcloud components update
RUN gcloud components install gsutil beta
ADD docker-config.json /root/.docker/config.json

ENV KUBECTL_VERSION 1.11.0
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl > /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

ENV HELM_VERSION 2.9.1
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-v$HELM_VERSION-linux-amd64.tar.gz | tar -xzf - --strip-components=1 -C /usr/local/bin linux-amd64/helm
RUN helm init --client-only

RUN easy_install-2.7 pip
RUN pip install awscli --upgrade
