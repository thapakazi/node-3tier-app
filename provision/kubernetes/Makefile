CLUSTER_NAME?=node-3tier-app-d50e9d69
REGION?=asia-south1

create-gitlab-svc-account:
	@kubectl apply -f gitlab-admin-service-account.yml

get-cluster-info:
	@echo -n SERVER:
	@kubectl cluster-info|awk '/Kubernetes master/{print $$NF}'

	@echo "########################################"
	@echo -n CERTIFICATE_AUTHORITY_DATA:
	@gcloud container clusters describe $(CLUSTER_NAME) --region $(REGION) |awk '/clusterCaCertificate/{print $$NF}'

	@echo "########################################"
	@echo -n USER_TOKEN:
	@kubectl describe secret $(shell kubectl -n kube-system get secret | awk '/gitlab-admin/{print $$1}') -n kube-system|awk '/token:/{print $$NF}'
