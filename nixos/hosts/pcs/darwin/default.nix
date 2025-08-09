{ config,
     pkgs,
     vars, ... }:
let
  user = vars.user.name;
in
{
  imports = [
    ../../../modules/darwin/home-manager.nix
    ../../../modules/common
  ];

  nix = {
    package = pkgs.nix;

    settings = {
      trusted-users = [ "@admin" "${user}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

#  Darwin Specific Modules for Installation
  environment.systemPackages = with pkgs; [
  ] ++ (import ./packages.nix { inherit pkgs; });


  system = {
    checks.verifyNixPath = false;
    primaryUser = user;
    stateVersion = 6;

    defaults = {
      NSGlobalDomain = {
#        AppleShowAllExtensions = true;
#        ApplePressAndHoldEnabled = false;
        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 15; # Values: 120, 94, 68, 35, 25, 15

#        "com.apple.mouse.tapBehavior" = 1;
#        "com.apple.sound.beep.volume" = 0.0;
#        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
#        tilesize = 48;
      };

      # TBD not working Increase font size for the standard macOS Terminal.app profile
#      CustomUserDefaults = {
#        "com.apple.Terminal" = {
#          # Use the built-in "Pro" profile for both default and startup windows
#          "Default Window Settings" = "Pro";
#          "Startup Window Settings" = "Pro";
#          # Override settings for the "Pro" profile
#          "Window Settings" = {
#            Pro = {
#              # Increase the font size; keep other settings intact
#              "FontSize" = 14.0;
#            };
#          };
#        };
#      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };
}
