# encoding: UTF-8

GIT_REVISION=$(shell git rev-parse --short HEAD)

REGISTRY = docker.io
REPOSITORY = bluebeluga/ruby
FROM = bluebeluga/alpine

PUSH_REGISTRIES = $(REGISTRY)
