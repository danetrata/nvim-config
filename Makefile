.PHONY: help

help: ## this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

upgrade: ## update python neovim providers
	pip install --upgrade neovim
	pip2 install --upgrade neovim
	pip3 install --upgrade neovim

default: ## make nvim default on the system
	update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
	update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
	update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

install: ## install from repositories
	apt-get -y install software-properties-common
	add-apt-repository -y ppa:neovim-ppa/stable
	apt-get -y install neovim
	apt-get -y install python-dev python-pip python3-dev python3-pip
