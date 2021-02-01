FROM alpine:3.13.1 as faas-cli

WORKDIR /root/

RUN apk update && apk add curl

RUN curl -LJO https://github.com/openfaas/faas-cli/releases/download/0.12.21/faas-cli && \
    chmod +x faas-cli

FROM docker:20.10.2 as docker-in-docker

WORKDIR /root/

COPY --from=faas-cli /root/faas-cli /usr/local/bin/faas-cli

RUN apk add git