# Toolbox

A small image with kubeclt and some related tools

## Tools

- Based on [`docker:latest`](https://hub.docker.com/_/docker/)
- Includes [gcloud](https://cloud.google.com/sdk/docs/quickstart-linux) and some components
  - gsutil
  - beta
- Includes [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Includes [Helm](https://helm.sh/)
- Includes [aws](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
- Includes [amazon-ecr-credential-helper)](https://github.com/awslabs/amazon-ecr-credential-helper)
- Includes [aws-iam-authenticator](https://github.com/kubernetes-sigs/aws-iam-authenticator)
- Includes git
- Includes [sentry-cli](https://docs.sentry.io/cli/)

## Use as ecr-login

Created wrapper script `/usr/bin/local/docker-credential-ecr-login`

```bash
#!/bin/bash
docker run \
  --rm -i \
  -v /etc/ssl/certs:/etc/ssl/certs \
  -e AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY \
  -e AWS_SESSION_TOKEN \
  ekreative/toolbox \
  docker-credential-ecr-login "$@"
```

Add to `~/.docker/config.json`

```json
{
  "credHelpers": {
    "${account}.dkr.ecr.${region}.amazonaws.com": "ecr-login"
  }
}
```

## Build

```bash
docker build -t ekreative/toolbox .
```
