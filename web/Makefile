APP_NAME?=web
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

get-ingress-ip:
	@kubectl get ingress web-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
