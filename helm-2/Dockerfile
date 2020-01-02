FROM golang:1.13-alpine as ecr-login
RUN apk add --no-cache git make bash
RUN go get -u -d github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login \
    && cd /go/src/github.com/awslabs/amazon-ecr-credential-helper \
    && make

FROM docker:latest
RUN apk add --no-cache \
      bash \
      curl \
      git \
      openssl \
      python3

# See latest version https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
ENV AWS_IAM_AUTHENTICATOR_VERSION 1.14.6/2019-08-22
RUN curl https://amazon-eks.s3-us-west-2.amazonaws.com/$AWS_IAM_AUTHENTICATOR_VERSION/bin/linux/amd64/aws-iam-authenticator > /usr/local/bin/aws-iam-authenticator \
    && chmod 0755 /usr/local/bin/aws-iam-authenticator

# See latest version at https://sentry.io/get-cli/
ENV SENTRY_CLI_VERSION 1.49.0
RUN curl https://downloads.sentry-cdn.com/sentry-cli/$SENTRY_CLI_VERSION/sentry-cli-Linux-x86_64 > /usr/local/bin/sentry-cli \
    && chmod 0755 /usr/local/bin/sentry-cli

# See latest version at https://storage.googleapis.com/kubernetes-release/release/stable.txt
ENV KUBECTL_VERSION 1.17.0
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl > /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# See latest version at https://pypi.org/project/awscli/
ENV AWS_VERSION 1.16.309
RUN pip3 install awscli==$AWS_VERSION
COPY --from=ecr-login /go/src/github.com/awslabs/amazon-ecr-credential-helper/bin/local/docker-credential-ecr-login /usr/local/bin/docker-credential-ecr-login

# Find latest link at https://cloud.google.com/sdk/docs/downloads-versioned-archives
ENV GCLOUD_SDK_VERSION 274.0.1
ENV PATH=/google-cloud-sdk/bin:$PATH
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$GCLOUD_SDK_VERSION-linux-x86_64.tar.gz | tar -xzf - \
    && /google-cloud-sdk/install.sh \
    && gcloud components install gsutil beta
ADD docker-config.json /root/.docker/config.json

# See latest version at https://github.com/helm/helm/releases
ENV HELM_VERSION 2.16.1
RUN curl https://get.helm.sh/helm-v$HELM_VERSION-linux-amd64.tar.gz | tar -xzf - --strip-components=1 -C /usr/local/bin linux-amd64/helm
##<helm2>##
RUN helm init --client-only
##</helm2>##
