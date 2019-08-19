RELEASE?=latest
build:
	@docker build -t gcr.io/node-3tier-app/api:$(RELEASE) .
publish:
	@docker push gcr.io/node-3tier-app/api:$(RELEASE)
release:
	@git rev-parse HEAD
