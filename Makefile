-include .env
GITHUB_TOKEN ?=
DOCKERHUB_USERNAME ?= rafaelcalleja
DOCKERHUB_TOKEN ?=
DOCKER_HOST ?= $(shell docker context inspect --format '{{.Endpoints.docker.Host}}')
REPOSITORY ?= rafaelcalleja/gost
EVENT ?= workflow_dispatch

build-locally:
	act $(EVENT) -a $(REPOSITORY) \
	-s GITHUB_TOKEN=$(GITHUB_TOKEN) \
	-s DOCKERHUB_USERNAME=$(DOCKERHUB_USERNAME) \
	-s DOCKERHUB_TOKEN=$(DOCKERHUB_TOKEN) \
	--env DOCKER_HOST=$(DOCKER_HOST) \
	--env GITHUB_REPOSITORY=$(REPOSITORY)
