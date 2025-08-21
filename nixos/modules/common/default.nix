{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  vars,
  ...
} @ args:
# Optional: give a name to the whole argument set
{
  imports = [
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs = {
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      alacritty
      bat
      zsh
      tmux
      fzf
      file
      git
      htop
      nodejs_22
      btop
      jq
      neovim
      vimPlugins.vim-plug
      unzip
      wget
      curl
      zip
      tree
      just
      gcc
      gnumake
      kubectl
    ];
  };


}
