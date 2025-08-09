{lib, ...}: rec {
  user = {
    name = "kirylbucha";
    fullName = "Kiryl Bucha";
    email = "kbucha@datamola.com";
    packages = {
      terminal = "alacritty";
      editor = "nvim";
      shell = "zsh";
    };
  };

  paths = {
    dotfiles = "$HOME/.dotfiles";
    configHome = "$HOME/.config";
    dataHome = "$HOME/.local/share";
    cacheHome = "$HOME/.cache";
  };

  system = {
    timeZone = "Europe/London";
    locale = "en_US.UTF-8";
    stateVersion = "24.05";
  };

  networking = {
    domain = "datamola.com";
  };
}
