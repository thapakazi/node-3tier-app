APP_NAME?=api
RELEASE?=$(shell git rev-parse HEAD)
REGISTRY_URL?=gcr.io
GCR_URL?=${REGISTRY_URL}/node-3tier-app/${APP_NAME}

build:
	@docker build -t ${GCR_URL}:$(RELEASE) .

publish: build
	docker push ${GCR_URL}:$(RELEASE)

.PHONY: deploy
deploy: publish
	 sed "s/latest/$(shell git rev-parse HEAD)/" deploy/deployment.yml |kubectl apply -f -

create-service:
	kubectl apply -f deploy/service.yml

print:
	echo ${GCR_URL}
