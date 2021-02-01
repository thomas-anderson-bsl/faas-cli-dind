# faas-cli-dind

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/thomasandersonbsl/faas-cli-dind?style=for-the-badge)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/thomasandersonbsl/faas-cli-dind?style=for-the-badge)

Docker image with only FaaS-CLI and Docker in Docker! Useful for CI/CD of OpenFaaS functions.

## Usage with Gitlab CI

```
# .gitlab-ci.yml

stages:
    - build

build-and-deploy-function:
    stage: build
    image: "$DOCKER_REGISTRY_URL/thomas-anderson-bsl/faas-cli-dind:latest"
    script:
        - faas-cli build --tag=sha
        - echo -n "$DOCKER_REGISTRY_PASSWORD" | docker login --username "$DOCKER_REGISTRY_USERNAME" --password-stdin "$DOCKER_REGISTRY_URL"
        - faas-cli push --tag=sha
        - echo -n "$OPENFAAS_PASSWORD" | faas-cli login --gateway "$OPENFAAS_URL" --username "$OPENFAAS_USERNAME" --password-stdin
        - faas-cli deploy --gateway "$OPENFAAS_URL" --tag=sha --send-registry-auth

```
