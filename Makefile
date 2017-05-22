TS_VERSION?=	7.0.0
RELEASE?=	1.0
FULL_VERSION?=	${TS_VERSION}-${RELEASE}

REPOSITORY?=	torchbox/trafficserver
IMAGE?=		${REPOSITORY}:${FULL_VERSION}

default: build

build:
	docker build -t ${IMAGE} --pull --build-arg=ts_version=${TS_VERSION} .

push:
	docker push ${IMAGE}

.PHONY: build push
