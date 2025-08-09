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

  programs.home-manager.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Initialize Home Directory
  home = {
    enableNixpkgsReleaseCheck = false;
    packages =with pkgs;
          [
            # fonts
            nerd-fonts.jetbrains-mono
            jetbrains-mono
          ]
            ++ (
              if pkgs.stdenv.hostPlatform.system != "aarch64-linux"
              then [
                # ARM does not support every package, so only install these if we're not on an ARM basd architecture
      #          bitwarden
              ]
              else []
            );

    # Explicitly set username and homeDirectory so Home Manager works on both NixOS and Darwin
    username = "${vars.user.name}";
    homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin
      then "/Users/${vars.user.name}"
      else "/home/${vars.user.name}";
    stateVersion = "25.05"; # home.stateVersion
  };

  # Marked broken Oct 20, 2022 check later to remove this
  # https://github.com/nix-community/home-manager/issues/3344
  manual.manpages.enable = false;
}
