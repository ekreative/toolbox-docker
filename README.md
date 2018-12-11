# Kubectl

A very simple docker image with kubectl installed

## More

Actually now its got a bit more going on

- Based on [`docker:latest`](https://hub.docker.com/_/docker/)
- Includes [gcloud](https://cloud.google.com/sdk/docs/quickstart-linux) and some components
  - gsutil
  - beta
- Includes [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Includes [Helm](https://helm.sh/)
- Includes [aws](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
- Includes git

## Build

```bash
docker build -t ekreative/kubectl .
```
