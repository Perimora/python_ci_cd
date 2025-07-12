RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[1;33m
BLUE=\033[0;34m
NC=\033[0m 

ifneq (,$(wildcard config/.env))
    include config/.env
    export
endif

VENV_ROOT=.venv
VENV_BIN=$(VENV_ROOT)/bin

.PHONY: install-dev install-pre-commit pre-commit lint format security bandit safety pip-audit test-fast test coverage-report coverage-html coverage-xml coverage-check coverage-clean clean

install-dev:
	sudo apt update && sudo apt install -y python3 python3-venv python3-pip
	@if [ ! -d "$(VENV_ROOT)" ]; then \
		python3 -m venv $(VENV_ROOT) && \
		echo "Virtual environment created at $(VENV_ROOT)"; \
	else \
		echo "Using existing virtual environment at $(VENV_ROOT)"; \
	fi
	$(VENV_ROOT)/bin/pip install --upgrade pip
	$(VENV_ROOT)/bin/pip install -r requirements-dev.txt
	@echo -e "$(GREEN)[+] Development environment is ready. Activate it with: source $(VENV_BIN)/activate"

install-pre-commit:
	$(VENV_BIN)/pre-commit install

pre-commit:
	$(VENV_BIN)/pre-commit run --all-files

lint:
	$(VENV_BIN)/black --check --diff --config config/pyproject.toml .
	$(VENV_BIN)/flake8 --config config/setup.cfg
	$(VENV_BIN)/isort --check --diff --settings-path config/pyproject.toml src test
	$(VENV_BIN)/mypy --config-file config/setup.cfg src test

format:
	$(VENV_BIN)/black --config config/pyproject.toml .
	$(VENV_BIN)/isort --settings-path config/pyproject.toml src test

security: bandit safety pip-audit

bandit:
	$(VENV_BIN)/bandit -r src -x test -c config/bandit.yaml

safety:
	SAFETY_API_KEY=$(SAFETY_API_KEY) $(VENV_BIN)/safety scan --full-report --file=requirements-dev.txt

pip-audit:
	$(VENV_BIN)/pip-audit

test-fast:
	$(VENV_BIN)/pytest test

test:
	$(VENV_BIN)/coverage run --rcfile=config/.coveragerc -m pytest

coverage-report: coverage-html coverage-xml

coverage-html:
	$(VENV_BIN)/coverage html --rcfile=config/.coveragerc

coverage-xml:
	$(VENV_BIN)/coverage xml --rcfile=config/.coveragerc

coverage-check:
	$(VENV_BIN)/coverage report --fail-under=80 --rcfile=config/.coveragerc

coverage-clean:
	rm -rf reports/coverage

clean:
	rm -rf __pycache__ .pytest_cache .mypy_cache .coverage .coverage.* .tox .eggs *.egg-info build dist .venv reports/
