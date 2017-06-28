TS_VERSION?=	7.1.x
RELEASE?=	1.0
FULL_VERSION?=	${TS_VERSION}-${RELEASE}

REPOSITORY?=	torchbox/trafficserver
IMAGE?=		${REPOSITORY}:${FULL_VERSION}

default: build

build:
	docker build -t ${IMAGE} --pull .

push:
	docker push ${IMAGE}

.PHONY: build push
