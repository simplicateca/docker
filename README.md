# Simplicate Docker Monorepo

This repo provides:

 - Production-ready base images for Python FastAPI and PHP-FPM

 - A unified Makefile for local build/test/push workflows

 - GitHub Actions pipelines for develop vs main branch builds

 - A library of compose.yaml configs for quickly bootstrapping supporting services

---

## 📦 Images

### 1. Python FastAPI

Located in: [`images/docker-python-fastapi`](./images/docker-python-fastapi)

- Based on **Python 3.13-slim**
- Includes:
  - FastAPI + Uvicorn
  - OpenAI, LangChain, Meilisearch, MinIO
  - NLP libraries (`spacy`, `tiktoken`, `unstructured`)
  - File parsing libraries (`PyPDF2`, `pdfplumber`, `python-docx`, `openpyxl`, `pandas`, etc.)
  - Media processing (`ffmpeg`, `moviepy`, `pydub`, `vosk`)
  - CLI tools: `mc` (MinIO client), `jq`, `yq`, `curl`, `wget`, `nano`
- Intended as a **general-purpose base image** for Python APIs and helper services.

### 2. PHP-FPM (Craft CMS)

Located in: [`images/docker-php-fpm`](./images/docker-php-fpm)

- Based on **php:8.3-fpm**
- Includes:
  - Common PHP extensions (gd, intl, ldap, imap, zip, opcache, soap, xsl, etc.)
  - PECL extensions (xdebug, redis, imagick, xmlrpc)
- Optimized for **Craft CMS** and other PHP web apps.

---

## 🛠 Build & Run

A single [Makefile](./Makefile) at the project root provides commands
to build, run, and push either image.

### Environment

- `IMAGE` → target image (`python-fastapi` or `php-fpm`)
- `VERSION` → tag version (`dev`, `1.0.0`, etc.)

### Commands

#### Build

Builds the image locally

```bash
make build IMAGE=python-fastapi VERSION=dev
```

#### Run

Runs the container locally, exposing port 8000 for FastAPI (or PHP-FPM defaults).

```bash
make run IMAGE=python-fastapi VERSION=dev
```

#### Shell

Opens an interactive shell inside the container.

```bash
make shell IMAGE=php-fpm VERSION=dev
```

#### Push to Docker Hub

Pushes the built image to Docker Hub under both :1.0.0 and :latest.

```bash
make push IMAGE=python-fastapi VERSION=1.0.0
```

### Test Build

Runs a build and lists the resulting images.

```bash
make test-build IMAGE=python-fastapi
```

#### GitHub Develop Trigger

Commits and pushes to the develop branch, triggering a CI build (test only).

```bash
make push-develop IMAGE=python-fastapi
```

## 🚀 CI/CD

develop branch → performs a test build (does not push to Docker Hub).

main branch → performs a full build, tags images with latest and commit SHA, and pushes to Docker Hub.

Images are built for multiple platforms: linux/amd64 and linux/arm64.

## 🗂 Containers Directory

The [`containers/`](./containers) folder contains a curated set of
`compose.yaml` files for quickly spinning up commonly used services.

Current services:

- **meilisearch** → Lightning-fast, open-source search engine with a developer-friendly API.
- **miniflux** → Minimalist, self-hosted RSS reader with APIs and integrations.
- **minio** → S3-compatible object storage, great for local or production use.
- **n8n** → Workflow automation platform, similar to Zapier, but self-hosted.
- **plausible** → Lightweight, privacy-friendly web analytics alternative to Google Analytics.
- **wallabag** → Self-hosted “read-it-later” app for saving and archiving articles.

### Usage

Each folder contains a `compose.yaml` file. To run any service:

```bash
docker compose -f containers/<service>/compose.yaml up -d
```

## 🔑 Secrets

GitHub Actions workflows require the following secrets set at the repo level:

`DOCKERHUB_USERNAME` → your Docker Hub username (simplicateca)

`DOCKERHUB_TOKEN` → a Docker Hub access token with push permissions
