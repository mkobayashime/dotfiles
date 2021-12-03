all:

submodule:
	git submodule update --init

deploy:
	./deploy.sh
