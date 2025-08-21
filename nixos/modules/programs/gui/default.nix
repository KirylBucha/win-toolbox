{ pkgs, lib, vars, ... }: {
  # Configure GUI-related programs for the user environment via Home Manager
  # Increase terminal font size for Alacritty (the selected terminal in vars)
  programs.alacritty = lib.mkIf (vars.user.packages.terminal == "alacritty") {
    enable = true;
    settings = {
      font = {
        # Use JetBrainsMono Nerd Font which is already installed in home.packages
        normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
        bold = { family = "JetBrainsMono Nerd Font"; style = "Bold"; };
        italic = { family = "JetBrainsMono Nerd Font"; style = "Italic"; };
        size = 14.0; # Increased terminal font size
      };
    };
  };
}
