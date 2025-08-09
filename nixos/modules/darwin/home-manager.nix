{ config, pkgs, lib, inputs, outputs, vars, ... }:
let
  user = "${vars.user.name}";
in
{
  imports = [
     inputs.home-manager.darwinModules.home-manager
  ];

  # Darwin users configuration
  users = {
    # Ensure these users are known to nix-darwin (pre-existing or managed accounts)
    knownUsers = [ "${user}"];
  };

  # Register User
  users.users.${user} = {
    uid = 501;
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.${vars.user.packages.shell};
  };

  # Initialize Home-Manager with Registered User
  home-manager = {
#    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    # Make inputs and vars available to the imported home module
    extraSpecialArgs = {
      inherit inputs outputs vars;
    };
    users.${user} = import ../../modules/home;
  };

  # Initialized Home Brew
  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)
    masApps = {
      # "wireguard" = 1451685025;
    };
  };
}
