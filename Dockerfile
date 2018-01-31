FROM docker:latest
RUN apk add --no-cache python2 bash curl openssl
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-186.0.0-linux-x86_64.tar.gz | tar -xzf -
RUN /google-cloud-sdk/install.sh
ENV PATH=/google-cloud-sdk/bin:$PATH
RUN gcloud components install kubectl gsutil beta docker-credential-gcr
RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
RUN helm init --client-only
