{ config, pkgs, lib, inputs, outputs, vars, ... }:
let
  user = "${vars.user.name}";
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Ensure both users exist during transition
  # Register Users
  users.users = {
#    nixos = {
#      isNormalUser = true;
#      extraGroups = ["wheel" "networkmanager"];
#      # Keep nixos user temporarily
#    };
    ${vars.user.name} = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "docker"];
      initialPassword = "password";
      ignoreShellProgramCheck = true;
      shell = pkgs.${vars.user.packages.shell};
    };
  };

  # Initialize Home-Manager with Registered User
  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs vars;
    };
    users.${vars.user.name} = import ../../modules/home;
  };

  # Docker-Compose
  virtualisation = {
    libvirtd.enable = false;
    docker.enable = true;
    podman.enable = false;
  };

  # Additional programs
  programs = {
    nix-ld.enable = true;
    virt-manager.enable = false;
  };


}
