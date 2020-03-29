DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard _??*)
EXCLUSIONS := _bin
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

all:

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

check: ## Check if symlink to home directory exists
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(HOME)/$(patsubst _%,.%,$(val));)

install: ## Create symlink to home directory
	@echo 'Deploy dot files to home directory...'
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(patsubst _%,.%,$(val));)

install-plugs:
	./scripts/install-vim-plug
	./scripts/install-zplug

clean: ## Unlink the dot files and this repo
	@echo 'Unlink dot files in your home directory...'
	@$(foreach val, $(DOTFILES), /bin/rm -v $(HOME)/$(patsubst _%,.%,$(val));)
