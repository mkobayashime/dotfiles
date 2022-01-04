all:

submodule:
	git submodule update --init

deploy: submodule
	./deploy.sh
