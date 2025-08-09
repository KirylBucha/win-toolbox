{
  inputs,
  vars,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../programs/tui
    ../programs/gui
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    stateVersion = "25.05";
  };

#  home = {
#    enableNixpkgsReleaseCheck = false;
##    packages = pkgs.callPackage ./packages.nix {};
#    packages =with pkgs;
#          [
#            # fonts
#            nerd-fonts.jetbrains-mono
#            jetbrains-mono
#          ];
#    # Explicitly set username and homeDirectory so Home Manager works on both NixOS and Darwin
#    username = vars.user.name;
#    homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin
#      then "/Users/${vars.user.name}"
#      else "/home/${vars.user.name}";
#    stateVersion = "23.11";
#  };


  # Marked broken Oct 20, 2022 check later to remove this
  # https://github.com/nix-community/home-manager/issues/3344
  manual.manpages.enable = false;


#  # User packages. IE not system packages
#  home = {
##    username = "${vars.user.name}";
##    homeDirectory = "/Users/${vars.user.name}";
#    packages = with pkgs;
#      [
#        # fonts
#        nerd-fonts.jetbrains-mono
#        jetbrains-mono
#      ]
#      ++ (
#        if pkgs.stdenv.hostPlatform.system != "aarch64-linux"
#        then [
#          # ARM does not support every package, so only install these if we're not on an ARM basd architecture
##          bitwarden
#        ]
#        else []
#      );
#      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
#      stateVersion = "24.05";
#  };

  programs.home-manager.enable = true;


}
