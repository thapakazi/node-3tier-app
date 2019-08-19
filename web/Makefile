RELEASE?=latest
build:
	@docker build -t gcr.io/node-3tier-app/web:$(RELEASE) .
publish:
	@docker push gcr.io/node-3tier-app/web:$(RELEASE)
release:
	@git rev-parse HEAD
