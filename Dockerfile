FROM alpine:3.5
ENV KUBE_VERSION 1.5.4
ADD https://storage.googleapis.com/kubernetes-release/release/v$KUBE_VERSION/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
CMD ["kubectl"]
