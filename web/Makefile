APP_NAME?=web
RELEASE?=$(shell git rev-parse HEAD)
REGISTRY_URL?=gcr.io
GCR_URL?=${REGISTRY_URL}/node-3tier-app/${APP_NAME}
REGION?="asia-south1"

build:
	@docker build -t ${GCR_URL}:$(RELEASE) .

publish: build
	docker push ${GCR_URL}:$(RELEASE)

.PHONY: deploy
deploy: publish
	 sed "s/latest/$(shell git rev-parse HEAD)/" deploy/deployment.yml |kubectl apply -f -

lint:
	@npm run lint

lint-fix:
	@npm run lint-fix

create-backend:
	kubectl apply -f deploy/backend-config.yml

create-service:
	kubectl apply -f deploy/service.yml

get_static_ip:
	gcloud compute addresses create static-ip --region ${REGION} || true
	gcloud compute addresses describe static-ip --region ${REGION}

create-ingress: create-backend create-service
	kubectl apply -f deploy/ingress.yml

get-ingress-ip:
	kubectl get ingress web-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
