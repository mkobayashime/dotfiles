biome = bunx biome
typecheck = bunx --bun tsc --noEmit

all:

deps: PHONY
	bun install

lint: deps PHONY
	$(biome) check .

lint.fix: deps PHONY
	$(biome) check --write .

typecheck: deps PHONY
	$(typecheck)

typecheck.watch: deps PHONY
	$(typecheck) --watch

submodule: PHONY
	git submodule update --init

deploy: submodule PHONY
	./deploy.sh

tools: PHONY
	./installers/index.sh

packages: PHONY
	zsh -ci 'source ./install-packages.zsh'

agents.sync.all: PHONY
	agents/sync.ts all
	git status agents

agents.deploy: PHONY
	agents/deploy.ts

setup: deploy tools PHONY

PHONY:
