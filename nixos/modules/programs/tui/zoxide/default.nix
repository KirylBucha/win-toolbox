{
  pkgs,
  lib,
  config,
  ...
}: {

  home.packages = with pkgs; [
    zoxide
  ];

  # Enable zoxide and its zsh integration
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
}