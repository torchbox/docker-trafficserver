REPOSITORY?=	torchbox/trafficserver

default: build

build:
	docker build -f Dockerfile-7.0 -t ${REPOSITORY}:7.0 .

push:
	docker push ${REPOSITORY}:7.0

.PHONY: build push
