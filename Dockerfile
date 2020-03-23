FROM python:3-alpine

ARG KUBECTL_VERSION=1.14.0
ARG JQ_VERSION=1.5
ARG YQ_VERSION=1.15.0
ARG HELM_VERSION=2.9.1

RUN apk update && \
    apk add --no-cache \
    ca-certificates \
    curl \
    openssl \
    tar \
    gnupg \
    bash \
    grep \
    busybox-extras \
    xz \
    && update-ca-certificates \
    && rm /usr/bin/[[

# Install kubectl
RUN curl -sL https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && chmod a+x /usr/local/bin/kubectl

# Install awscli
RUN pip3 install awscli

# Install jq
RUN curl -sL https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 -o /usr/local/bin/jq && chmod a+x /usr/local/bin/jq

# Install yq
RUN curl -sL https://github.com/mikefarah/yq/releases/download/1.15.0/${YQ_VERSION}_linux_amd64 -o /usr/local/bin/yq && chmod a+x /usr/local/bin/yq

# Install helm
RUN curl -sL https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz \
    && tar xzf helm.tar.gz \
    && mv ./linux-amd64/helm /usr/local/bin/helm \
    && chmod a+x /usr/local/bin/helm

WORKDIR /apps
