all:

.PHONY: submodule
submodule:
	git submodule update --init

.PHONY: deploy
deploy: submodule
	./deploy.sh

.PHONY: tools
tools:
	./installers/index.sh

.PHONY: packages
packages:
	zsh -ci 'source ./install-packages.zsh'

.PHONY: setup
setup: deploy tools
