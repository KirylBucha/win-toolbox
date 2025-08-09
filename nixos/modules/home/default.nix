{
  inputs,
  vars,
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


  # User packages. IE not system packages
  home = {
    username = "${vars.user.name}";
#    homeDirectory = "/Users/${vars.user.name}";
    packages = with pkgs;
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
  };

  services.mako.enable = false;
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
