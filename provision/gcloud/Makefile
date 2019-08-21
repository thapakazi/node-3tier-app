import:
	@terraform import -provider=google-beta google_compute_network.vpc_default default

plan:
	@terraform plan -out /tmp/plan

apply:
	@terraform apply /tmp/plan

run: import plan apply

get-kubeconfig:
	@gcloud container clusters get-credentials "$(shell terraform output cluster_name)" --region "$(shell terraform output region)"

get-outputs:
	@terraform output

generate-api-secrets:
	@kubectl create secret generic api-secrets  --from-literal "DB=$(shell terraform output database_url)"
	@kubectl describe secret/api-secrets

generate-web-secrets:
	@kubectl create secret generic web-secrets  --from-literal "API_HOST=http://api"
	@kubectl describe secret/web-secrets


clean:
	rm -rf ~/.kube/config
	terraform state rm google_compute_network.vpc_default
