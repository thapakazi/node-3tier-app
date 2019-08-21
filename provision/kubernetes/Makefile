CLUSTER_NAME?=node-3tier-app-c168819e
REGION?=asia-south1

create-gitlab-svc-account:
	@kubectl apply -f gitlab-admin-service-account.yml

get-cluster-info:
	@echo -n SEVER:> /tmp/info
	@kubectl cluster-info|awk '/Kubernetes master/{print $$NF}' >> /tmp/info

	@echo "------" >> /tmp/info
	@echo -n CERTIFICATE_AUTHORITY_DATA: >> /tmp/info
	@gcloud container clusters describe $(CLUSTER_NAME) --region $(REGION) |awk '/clusterCaCertificate/{print $$NF}' >> /tmp/info

	@echo "------" >> /tmp/info
	@echo -n USER_TOKEN: >> /tmp/info
	@kubectl describe secret $(shell kubectl -n kube-system get secret | awk '/gitlab-admin/{print $$1}') -n kube-system|awk '/token:/{print $$NF}'  >> /tmp/info

	cat /tmp/info
