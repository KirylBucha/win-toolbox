{
  pkgs,
  lib,
  config,
  ...
}: {
  # Install OpenShift CLI (OC), Kubectl, and Helm tools
  environment.systemPackages = with pkgs; [
    # Kubectl - available directly in nixpkgs
    kubectl
    
    # Helm - available directly in nixpkgs
    kubernetes-helm
    
    # OpenShift CLI (OC) - using nixpkgs if available
    openshift-client
  ];
}