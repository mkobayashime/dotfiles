all:

submodule:
	git submodule update --init

deploy: submodule
	./deploy.sh

tools:
	./installers/index.sh

setup: deploy tools
