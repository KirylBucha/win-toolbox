{
  pkgs,
  lib,
  config,
  ...
}: {

  # packages for administration tasks
  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes
  ];

  home.packages = with pkgs; [
    # Helm - available directly in nixpkgs
    kubernetes-helm

    # OpenShift CLI (OC) - using nixpkgs if available
    openshift
  ];
}