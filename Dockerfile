FROM docker:latest
RUN apk add --no-cache python2 bash curl openssl py-setuptools git

# Find latest link at https://cloud.google.com/sdk/docs/downloads-versioned-archives
ENV GCLOUD_SDK_VERSION 228.0.0
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$GCLOUD_SDK_VERSION-linux-x86_64.tar.gz | tar -xzf -
RUN /google-cloud-sdk/install.sh
ENV PATH=/google-cloud-sdk/bin:$PATH
# Keep fixed version
#RUN gcloud components update
RUN gcloud components install gsutil beta
ADD docker-config.json /root/.docker/config.json

# See latest version at https://storage.googleapis.com/kubernetes-release/release/stable.txt
ENV KUBECTL_VERSION 1.13.1
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl > /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

# See latest version at https://github.com/helm/helm/releases
ENV HELM_VERSION 2.12.1
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-v$HELM_VERSION-linux-amd64.tar.gz | tar -xzf - --strip-components=1 -C /usr/local/bin linux-amd64/helm
RUN helm init --client-only

RUN easy_install-2.7 pip

# See latest version at https://pypi.org/project/awscli/ 
ENV AWS_VERSION 1.16.79
RUN pip install awscli==$AWS_VERSION
