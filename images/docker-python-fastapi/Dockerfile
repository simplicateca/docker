# Stage 1: Builder
FROM python:3.13-slim AS builder

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
       build-essential \
       git \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir --prefix=/install -r /tmp/requirements.txt

# Stage 2: Runtime
FROM python:3.13-slim

LABEL maintainer="Steve Comrie <steve@simplicate.ca>"

ENV YQ_VERSION=v4.44.3

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
       nano \
       curl \
       wget \
       ffmpeg \
       imagemagick \
       ghostscript \
       jq \
    && curl -fsSL https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 \
       -o /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    && curl -fsSL https://dl.min.io/client/mc/release/linux-amd64/mc \
       -o /usr/bin/mc \
    && chmod +x /usr/bin/mc \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
