upgrade:
	pip install --upgrade neovim
	pip2 install --upgrade neovim
	pip3 install --upgrade neovim

default:
	update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
	update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
	update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
