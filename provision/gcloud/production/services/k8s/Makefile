PLAN_FILE?=/tmp/plan

plan:
	terraform plan -out ${PLAN_FILE}

exec: plan
	terraform apply ${PLAN_FILE}

output:
	terraform output

