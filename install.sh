# install nix
curl -L https://nixos.org/nix/install | sh

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# . ~/.nix-profile/etc/profile.d/nix.fish

# install packages
nix-env -iA \
	nixpkgs.git \
	nixpkgs.neovim \
	nixpkgs.stow \
	nixpkgs.fzf \
	nixpkgs.ripgrep \
	nixpkgs.bat \
	nixpkgs.direnv \
  nixpkgs.zellij


git clone https://github.com/NvChad/NvChad $HOME/.config/nvim

# stow dotfiles

stow nvchad
stow zellij
stow starship



