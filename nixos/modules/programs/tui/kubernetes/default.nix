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
    
    # OpenShift CLI (OC) - custom download from specified URL
#    (
#      let
#        version = "latest";
#      in
#      pkgs.runCommand "openshift-client-${version}" {
#        nativeBuildInputs = [ pkgs.gnutar pkgs.curl ];
#        # Use SSL certificates from the system
#        SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
#      } ''
#        # Create bin directory
#        mkdir -p $out/bin
#
#        # Download the latest oc client
#        curl -L https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz -o oc.tar.gz
#
#        # Extract and install
#        tar -xzf oc.tar.gz -C $out/bin
#        chmod +x $out/bin/oc
#
#        # Add version info
#        $out/bin/oc version > $out/version.txt 2>&1 || true
#      ''
#    )
  ];
}