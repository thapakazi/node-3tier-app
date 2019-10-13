PLAN_FILE?=/tmp/plan

plan:
	terraform plan -out ${PLAN_FILE}

exec: plan
	terraform apply ${PLAN_FILE}

output:
	terraform output

get-kubeconfig:
	gcloud container clusters \
		get-credentials "$(shell terraform output cluster_name)" \
		--region "$(shell terraform output region)" \
		--project "$(shell terraform output project_id)"

import_states:
	terraform import -provider=google-beta \
	modules.db.google_compute_network.vpc_default default
