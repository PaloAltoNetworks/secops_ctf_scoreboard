  
.PHONY: docker packer test

REQS := requirements.txt
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
	@python3 -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: ## Cleanup all the things
	find . -name '*.pyc' | xargs rm -rf
	find . -name '__pycache__' | xargs rm -rf
	rm -rf packer*
	rm -rf myvenv

docker: ## do the docker stuff
	$(MAKE) print-status MSG="Building with docker-compose"
	@if [ -f /.dockerenv ]; then echo "Don't run make docker inside docker container" && exit 1; fi
	docker-compose -f docker/docker-compose.yml -p 8080:8080 build scoreboard
	$(MAKE) python_three
	@echo "Now type: docker-compose -f docker/docker-compose.yml -p 8080:8080 run scoreboard /bin/bash"

packer: ## Build and amazon AMI for the scoreboard
	$(MAKE) print-status MSG="Validate Packer Configuration..."
	packer validate scoreboard.json
	#$(MAKE) print-status MSG="Build AMI with Packer..."
	#packer build scoreboard.json

print-status:
	@:$(call check_defined, MSG, Message to print)
	@echo "$(BLUE)$(MSG)$(NC)"

python_three: ## set up the python3 environment
	$(MAKE) print-status MSG="Set up the Python3 environment"
	python3 -m pip install wheel
	if [ -e "/tmp/project/requirements.txt" ]; then python3 -m pip install -rrequirements.txt; fi
	if [ -e "/tmp/project/requirements-test.txt" ]; then python3 -m pip install -rrequirements-test.txt; fi
