oxlint = bunx oxlint
oxfmt = bunx oxfmt
typecheck = bunx --bun tsc --noEmit

all:

deps: PHONY
	bun install

lint: deps PHONY
	$(oxlint) --type-aware
	$(oxfmt) --check

lint.fix: deps PHONY
	$(oxlint) --fix --type-aware
	$(oxfmt)

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

setup: deploy tools PHONY

PHONY:
