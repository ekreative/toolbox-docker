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
- Includes git
- Includes [sentry-cli](https://docs.sentry.io/cli/)

## Build

```bash
docker build -t ekreative/toolbox .
```
