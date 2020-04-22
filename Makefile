DOCKER_USERNAME?=rafaeljesus
NAME=dummy-service
BUILD_DIR?=bin
GO_LINKER_FLAGS=-ldflags="-s -w"

all: build docker-build docker-push docker-run
docker-all: docker-build docker-push docker-run

build:
	@rm -rf bin
	@CGO_ENABLED=0 go build -mod vendor ${GO_LINKER_FLAGS} -o ${BUILD_DIR}/${NAME} ${NAME}

docker-build:
	@docker build --no-cache --rm -t ${DOCKER_USERNAME}/${NAME}:latest .

docker-push:
	@docker push ${DOCKER_USERNAME}/${NAME}

docker-run:
	@docker run -i ${DOCKER_USERNAME}/${NAME}

bin-run:
	./bin/${NAME}

.PHONY: all build docker-build docker-push docker-run
