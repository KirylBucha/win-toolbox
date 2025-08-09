{ inputs, outputs, lib, config, pkgs, vars, ... } @ args:
let
  inherit (lib) mkIf mkMerge;
in
mkMerge [
  {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    system.autoUpgrade = {
      enable = true;
      allowReboot = true;
    };

    home-manager = {
      extraSpecialArgs = {
        inherit inputs outputs vars;
      };
      users.${vars.user.name} = import ../../modules/home;
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];

    nixpkgs = {
      overlays = [
        inputs.nix-vscode-extensions.overlays.default
      ];
      config = {
        allowUnfree = true;
      };
    };

    # Cross-platform packages
    environment = {
      systemPackages = with pkgs; [
        bat
        zsh
        tmux
        fzf
        file
        git
        btop
        jq
        neovim
        vimPlugins.vim-plug
        unzip
        wget
        curl
        zip
        tree
        just
        gcc
        gnumake
        kubectl
      ];
    };
  }

  # Linux-only settings (not available on Darwin)
  (mkIf pkgs.stdenv.isLinux {
    networking.networkmanager.enable = true;

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

    programs.nix-ld.enable = true;

    # Docker-Compose and virtualization
    virtualisation = {
      libvirtd.enable = false;
      docker.enable = true;
      podman.enable = false;
    };

    programs = {
      virt-manager.enable = false;
    };

    users.users.${vars.user.name} = {
  #    initialPassword = "password";
      isNormalUser = true;
      description = "${vars.user.fullName}";
      extraGroups = ["networkmanager" "wheel" "input" "docker"];
      ignoreShellProgramCheck = true;
      shell = pkgs.${vars.user.packages.shell};
    };

    system.stateVersion = "24.05";
  })
]
