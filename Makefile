all:

submodule:
	git submodule update --init

deploy: submodule
	./deploy.sh

tools:
	./installers/index.sh

packages:
	zsh -ci 'source ./install-packages.zsh'

setup: deploy tools
