biome = bunx biome

all:

deps: PHONY
	bun install

lint: deps PHONY
	$(biome) check .

lint.fix: deps PHONY
	$(biome) check --write .

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
