{
  pkgs,
  lib,
  config,
  ...
}: {
#  programs.kubectl = {
#    enable = true;
#  };

  home.packages = with pkgs; [
    # Helm - available directly in nixpkgs
    kubernetes-helm

    # OpenShift CLI (OC) - using nixpkgs if available
    openshift
  ];
}