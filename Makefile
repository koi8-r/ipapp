.DEFAULT_GOAL := test
define BROWSER_PYSCRIPT
import os, webbrowser, sys
try:
	from urllib import pathname2url
except:
	from urllib.request import pathname2url

webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT


VENV_PATH ?= .venv
VENV_BIN=$(VENV_PATH)/bin
BROWSER := $(VENV_BIN)/python -c "$$BROWSER_PYSCRIPT"

.PHONY: clean
clean: clean-pyc clean-build clean-test clean-venv clean-docs clean-mypy  ## Remove all build, test, coverage and Python artifacts

.PHONY: clean-build
clean-build:  ## Remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

.PHONY: clean-pyc
clean-pyc:  ## Remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

.PHONY: clean-test
clean-test:  ## Remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

.PHONY: clean-docs
clean-docs:  ## Remove docs artifacts
	rm -rf docs/build
	rm -rf docs/source/ipapp*.rst
	rm -rf docs/source/modules.rst

.PHONY: clean-mypy
clean-mypy:  ## Remove mypy cache
	rm -rf .mypy_cache

.PHONY: clean-venv
clean-venv:  ## Remove virtual environment
	-rm -rf $(VENV_PATH)

$(VENV_PATH):  ## Create a virtual environment
	virtualenv -p python3.7 $@

$(VENV_PATH)/pip-status: requirements.txt requirements_dev.txt | $(VENV_PATH) ## Install (upgrade) all development requirements
	$(VENV_BIN)/pip install --upgrade  --index-url http://pip.sys.ipl --trusted-host pip.sys.ipl -r requirements_dev.txt
	# keep a real file to be able to compare its mtime with mtimes of sources:
	touch $@

.PHONY: venv  # A shortcut for "$(VENV_PATH)/pip-status"
venv: $(VENV_PATH)/pip-status ## Install (upgrade) all development requirements

.PHONY: flake8
flake8: venv  ## Check style with flake8
	$(VENV_BIN)/flake8 ipapp examples setup.py tests

.PHONY: bandit
bandit: venv  ## Find common security issues in code
	$(VENV_BIN)/bandit -x ipapp/logic/db -r ipapp examples setup.py

.PHONY: mypy
mypy: venv  ## Static type check
	$(VENV_BIN)/mypy ipapp examples setup.py --ignore-missing-imports

.PHONY: safety
safety: venv  # checks your installed dependencies for known security vulnerabilities
	$(VENV_BIN)/safety check -r requirements.txt

.PHONY: black
black: venv  # checks imports order
	$(VENV_BIN)/black -S -l 79 --target-version  py37 examples ipapp tests setup.py --check

.PHONY: lint
lint: safety bandit mypy flake8 black  ## Run flake8, bandit, mypy

.PHONY: format
format: venv  ## Autoformat code
	$(VENV_BIN)/isort -rc ipapp examples tests
	$(VENV_BIN)/black -S -l 79 --target-version  py37 examples ipapp tests setup.py

.PHONY: test
test: venv  ## Run tests
	$(VENV_BIN)/docker-compose -f tests/docker-compose.yml up -d
	$(VENV_BIN)/pytest -v -s tests
	$(VENV_BIN)/docker-compose -f tests/docker-compose.yml kill

.PHONY: docs
docs-quiet: venv  ## Make documentation
	rm -f docs/source/ipapp.rst
	rm -f docs/source/modules.rst
	$(VENV_BIN)/sphinx-apidoc -o docs/source/ ipapp
	$(MAKE) -C docs clean
	$(MAKE) -C docs html

.PHONY: docs
docs: venv docs-quiet  ## Make documentation and open it in browser
	$(BROWSER) docs/build/html/index.html

.PHONY: help
help:  ## Show this help message and exit
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-23s\033[0m %s\n", $$1, $$2}'

