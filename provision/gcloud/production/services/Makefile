plan:
	cd k8s && terraform plan -out /tmp/plan

exec: plan
	cd k8s && terraform apply /tmp/plan
