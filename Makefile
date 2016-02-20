ansible_cmd = $(shell which "ansible-playbook" 2>/dev/null || echo "/usr/bin/ansible-playbook" )
ansible_vault_cmd = $(shell which "ansible-vault" 2>/dev/null || echo "/usr/bin/ansible-vault" )
ansible_vault_password_file = --vault-password-file ~/.secrets/.ansible-make-vault-key

# rewrite account
ifneq ($(strip $(account)),)
  ansible_cmd=AWS_PROFILE=$(account) ${ansible_cmd}
  aws_account=-e account=$(account)
else
  aws_account=
endif

# check option
ifneq (,$(findstring check,$(MAKECMDGOALS)))
  check=--check
else
  check=
endif

# rewrite region
ifneq (,$(findstring -, $(region)))
  aws_region=-e aws_region=$(region)
else
  aws_region=
endif

# rewrite commit
ifneq ($(strip $(commit)),)
  git_commit=-e commit=$(commit)
else
  git_commit=
endif

help:
## show this help
	@echo 'Available make targets:'
	@echo ''
	@grep -B1 '^## .*' ${MAKEFILE_LIST} | grep -v -- '^--$$' | sed -e 's/^## /	/' -e 's/^\([^:]*\):.*/  \1/'
	@echo ''

# --- hello world example

hello-world:
## print out hello world
	@echo hello world

# --- deploy web example
deploy-web:
## push out latest web configuration
	ansible-playbook web.yml -i localhost,

# -- sample

check:
## hack for check flag
	@echo check mode applied

run-playbook:
## run a generic playbook.
## > run-playbook play=playbook.yml [debug=debug-options]
	${ansible_cmd} $(play) $(debug) $(check)

run-playbook-with-vault:
## run a generic playbook with vault key file
## > run-playbook-with-vault play=playbook.yml [debug=debug-options]
	${ansible_cmd} $(play) ${ansible_vault_password_file} $(debug) $(check)

dynamic-inventory-clear-cache:
## clear dynamic inventory cache
## > dynamic-inventory-clear-cache
	AWS_PROFILE=$(account) ./inventory-ec2.sh --refresh-cache

ec2-create-instance:
## create an ec2 instance
## > ec2-create-instance env=<env> account=<account> region=<region> [dubug=debug-options] [check]
	${ansible_cmd} dorothy.yml ${ansible_vault_password_file} -e env=$(env) $(aws_account) $(aws_region) $(debug) $(check)

ec2-terminate-instance:
## terminate ec2 instance(s)
## > ec2-terminate-instance env=<env> account=<account> region=<region> [dubug=debug-options] [check]
	${ansible_cmd} dorothy-terminate.yml ${ansible_vault_password_file} -e env=$(env) $(aws_account) $(aws_region) $(debug) $(check)

edit-secrets: ${ANSIBLE_VAULT}
## edit secrets protected in ansible vault
## > edit-secrets
	${ANSIBLE_VAULT} edit ${ansible_vault_password_file} vars/secrets.yml
