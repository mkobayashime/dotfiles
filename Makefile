all:

submodule: PHONY
	git submodule update --init

deploy: submodule PHONY
	./deploy.sh

tools: PHONY
	./installers/index.sh

packages: PHONY
	zsh -ci 'source ./install-packages.zsh'

setup: deploy tools PHONY

PHONY:
