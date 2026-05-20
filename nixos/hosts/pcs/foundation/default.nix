{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  vars,
  ...
}: {
  imports = [
    ../../../modules/nixos/home-manager.nix
    ../../../modules/common
  ];

  networking.hostName = "kb-nixos-vs";
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  time.timeZone = vars.system.timeZone;

  i18n = {
    defaultLocale = vars.system.locale;
    extraLocaleSettings = {
      LC_ADDRESS = vars.system.locale;
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

### Service For LinuxVM ########
################################
#  services = {
#    xserver.enable = true;
#    displayManager.sddm.enable = true;
#    desktopManager.plasma6.enable = true;
#
#    xserver.xkb = {
#      layout = "us";
#      variant = "";
#    };
#
#    pipewire = {
#      enable = true;
#      alsa.enable = true;
#      alsa.support32Bit = true;
#      pulse.enable = true;
#    };
#  };
#  security.rtkit.enable = true;

################################
### WSL-2 Specific Configs
  # Override common settings that don't work well in WSL
  services = {
    xserver.enable = lib.mkForce false;
    displayManager.sddm.enable = lib.mkForce false;
    desktopManager.plasma6.enable = lib.mkForce false;
    pipewire.enable = lib.mkForce false;
  };

  # Disable unnecessary services for WSL
  security.rtkit.enable = lib.mkOverride 900 false;

  # WSL-specific settings
  wsl = {
    enable = true;
    defaultUser = vars.user.name;
    startMenuLaunchers = true;
    wslConf = {
      automount.root = "/mnt";
      network.generateResolvConf = true;
    };
  };

}
