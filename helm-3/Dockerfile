# Currently version 2 doesnt support alpine linux
# See latest version at https://hub.docker.com/r/amazon/aws-cli/tags
# FROM amazon/aws-cli:2.11.20 as aws-cli

# See latest version at https://hub.docker.com/_/docker
FROM docker:23
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
# hadolint ignore=DL3018
RUN apk add --no-cache \
# Used by some scripts
      bash \
      curl \
      git \
      jq \
      openssl \
# Deps for installed tools, gcloud and aws
      python3 \
      py3-pip

# See latest version at https://sentry.io/get-cli/
# https://github.com/getsentry/sentry-cli/releases
ENV SENTRY_CLI_VERSION=2.17.5
RUN curl "https://downloads.sentry-cdn.com/sentry-cli/$SENTRY_CLI_VERSION/sentry-cli-Linux-x86_64" >/usr/local/bin/sentry-cli \
    && chmod 0755 /usr/local/bin/sentry-cli

# See latest version at https://storage.googleapis.com/kubernetes-release/release/stable.txt
ENV KUBECTL_VERSION=1.27.1
RUN curl -L "https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl" >/usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# See latest version at https://pypi.org/project/awscli/
ENV AWS_VERSION 1.27.133
RUN pip3 install --no-cache-dir "awscli==$AWS_VERSION"
#COPY --from=aws-cli /usr/local/aws-cli/ /usr/local/aws-cli/
#COPY --from=aws-cli /usr/local/bin/aws /usr/local/bin/aws
#COPY --from=aws-cli /usr/local/bin/aws_completer /usr/local/bin/aws_completer

# https://github.com/awslabs/amazon-ecr-credential-helper/releases
ENV ECR_CREDENTIAL_HELPER_VERSION=0.7.0
RUN curl "https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/$ECR_CREDENTIAL_HELPER_VERSION/linux-amd64/docker-credential-ecr-login" >/usr/local/bin/docker-credential-ecr-login \
    && chmod 0755 /usr/local/bin/docker-credential-ecr-login

# Find latest link at https://cloud.google.com/sdk/docs/downloads-versioned-archives
ENV GCLOUD_SDK_VERSION=430.0.0
ENV PATH=/google-cloud-sdk/bin:$PATH
RUN curl "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$GCLOUD_SDK_VERSION-linux-x86_64.tar.gz" | tar -xzf - \
    && /google-cloud-sdk/install.sh \
    && gcloud components install gsutil beta gke-gcloud-auth-plugin
COPY docker-config.json /root/.docker/config.json

# See latest version at https://github.com/helm/helm/releases
ENV HELM_VERSION=3.12.0
RUN curl "https://get.helm.sh/helm-v$HELM_VERSION-linux-amd64.tar.gz" | tar -xzf - --strip-components=1 -C /usr/local/bin linux-amd64/helm
RUN helm plugin install https://github.com/helm/helm-2to3
