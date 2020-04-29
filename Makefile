.PHONY: docker packer python  test

REQS := python/requirements.txt
REQS_TEST := python/requirements.txt
# Used for colorizing output of echo messages
BLUE := "\\033[1\;36m"
NC := "\\033[0m" # No color/default

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
  match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
  if match:
    target, help = match.groups()
    print("%-20s %s" % (target, help))
    endef

export PRINT_HELP_PYSCRIPT

help: 
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: ## Cleanup all the things
	find . -name '*.pyc' | xargs rm -rf
	find . -name '__pycache__' | xargs rm -rf
	rm -rf packer*
	rm -rf myvenv

docker: ## do the docker stuff
	$(MAKE) print-status MSG="Building with docker-compose"
	@if [ -f /.dockerenv ]; then echo "Don't run make docker inside docker container" && exit 1; fi
	docker-compose -f docker/docker-compose.yml -p 8080:8080 build scoreboard
	@docker-compose -f docker/docker-compose.yml -p 8080:8080 run scoreboard /bin/bash

docs: python ## Generate documentation
	$(MAKE) print-status MSG="Building documentation with Sphinx"
	#sphinx-quickstart
	cd docs && make html

packer: python ## Build and amazon AMI for the scoreboard
	@if [ ! -f /.dockerenv ]; then echo "Run make packer inside docker container" && exit 1; fi
	$(MAKE) print-status MSG="Validate Packer Configuration..."
	if [ ! -f /tmp/project/packer ]; then wget https://releases.hashicorp.com/packer/1.5.5/packer_1.5.5_linux_amd64.zip && unzip /tmp/project/packer_1.5.5_linux_amd64.zip; fi
	/tmp/project/packer validate scoreboard.json
	#$(MAKE) print-status MSG="Build AMI with Packer..."
	#/tmp/project/packer build scoreboard.json

print-status:
	@:$(call check_defined, MSG, Message to print)
	@echo "$(BLUE)$(MSG)$(NC)"

python: ## setup python stuff
	if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="Run make python inside docker container" && exit 1; fi
	$(MAKE) print-status MSG="Set up the Python environment"
	if [ -f '$(REQS)' ]; then python3 -m pip install -r$(REQS); fi
