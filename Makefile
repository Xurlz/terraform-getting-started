up:
	terraform apply < <( echo yes )

down:
	terraform destroy < <( echo yes )

inventory-setup:
	IP=$$(terraform show | grep -G '\bpublic_ip\b' | tr -d '[:space:]' | cut -d= -f2 | sed -E 's/"([^"]+)"/\1/g' | tr -c -d '[:print:]'); \
	sed -ri "2s/([0-9]{1,3}\.?){4}/$$IP/g" inventory

ansible-playbook:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook playbook.yml -u ubuntu -i inventory --private-key ~/.ssh/treinamento-ci-cd-api-go.pem

.PHONY: up down inventory-setup ansible-playbook
