{
  vars,
  pkgs,
  lib,
  ...
}:
let
  tmuxConfig = pkgs.fetchFromGitHub {
    owner = "KirylBucha";
    repo = ".tmux";
    rev = "stable";
    sha256 = "sha256-4Mvq3bJMnnUBclj7Ld6mPRsgzqdm9gubFMKTXcDIvu0=";
  };
in
{
  programs.tmux = {
    enable = true;
  };

  # Clone the tmux configuration repository to .tmux directory
  home.file.".tmux" = {
    source = tmuxConfig;
    recursive = true;
  };

  # Create symbolic link to .tmux.conf by copying the file from .tmux directory
  home.file.".tmux.conf" = {
    source = "${tmuxConfig}/.tmux.conf";
  };

  # Copy .tmux.conf.local to home directory
  home.file.".tmux.conf.local" = {
    source = "${tmuxConfig}/.tmux.conf.local";
  };
}