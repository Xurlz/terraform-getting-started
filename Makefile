.ONESHELL:

inventory-setup:
	IP=`
		terraform show \
			| grep -G '\bpublic_ip\b' \
			| tr -d '[:space:]' \
			| cut -d= -f2 \
			| sed -E 's/"([^"]+)"/\1/g' \
			| tr -c -d '[:print:]'
	`

	sed -ri "2s/([0-9]{1,3}\.?){4}/$$IP/g" inventory

.PHONY: inventory-setup
