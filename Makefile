# ------------------------------------------------------------
# Project-wide Docker Makefile
# ------------------------------------------------------------

# Default image settings
IMAGE ?= python-fastapi   # or php-fpm
VERSION ?= dev
ORG = simplicateca
IMAGE_PATH = images/docker-$(IMAGE)

# Derived full image name
IMAGE_NAME = $(ORG)/$(IMAGE)

# ------------------------------------------------------------
# Build & Run Locally
# ------------------------------------------------------------

.PHONY: build
build:
	@echo "🚀 Building $(IMAGE_NAME):$(VERSION) and tagging as latest"
	docker build -t $(IMAGE_NAME):$(VERSION) -t $(IMAGE_NAME):latest $(IMAGE_PATH)

.PHONY: run
run:
	@echo "▶️  Running $(IMAGE_NAME):$(VERSION)"
	docker run -it --rm -p 8000:8000 -v $(PWD):/app $(IMAGE_NAME):$(VERSION)

.PHONY: shell
shell:
	docker run -it --rm -v $(PWD):/app $(IMAGE_NAME):$(VERSION) bash

# ------------------------------------------------------------
# Docker Hub Publishing
# ------------------------------------------------------------

.PHONY: login
login:
	@echo "🔑 Logging into Docker Hub..."
	docker login -u $(DOCKERHUB_USERNAME)

.PHONY: push
push:
	@if [ "$(VERSION)" = "dev" ]; then \
		echo "❌ Cannot push dev builds to Docker Hub. Use VERSION=X.Y.Z"; exit 1; \
	fi
	@echo "📤 Pushing $(IMAGE_NAME):$(VERSION) and latest to Docker Hub"
	docker push $(IMAGE_NAME):$(VERSION)
	docker push $(IMAGE_NAME):latest

# ------------------------------------------------------------
# Testing Helpers
# ------------------------------------------------------------

.PHONY: test-build
test-build: build
	@echo "✅ Build finished. Images available:"
	docker images | grep $(IMAGE_NAME)

.PHONY: test-dhub
test-dhub: test-build login push
	@echo "✅ Docker Hub push test finished!"

# ------------------------------------------------------------
# GitHub Workflow Kickoff
# ------------------------------------------------------------

.PHONY: push-develop
push-develop:
	@git checkout develop || true
	@git add .
	@git commit -m "chore: trigger develop build for $(IMAGE)" || true
	@git push origin develop
	@echo "✅ Commit pushed to develop for $(IMAGE) CI build"
