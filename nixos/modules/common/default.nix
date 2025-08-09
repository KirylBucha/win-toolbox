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
#    inputs.home-manager.nixosModules.home-manager
  ];

# TODO need to move to NixOS files
#  home-manager = {
#    extraSpecialArgs = {
#      inherit inputs outputs vars;
#    };
#    users.${vars.user.name} = import ../../modules/home;
#  };
#  system.stateVersion = "24.05";

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
      bat
      zsh
      tmux
      fzf
      file
      git
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
