{
  config,
  vars,
  pkgs,
  lib,
  ...
}:
{
      # Manual download of zsh-ssh plugin to oh-my-zsh custom directory
      home.file.".oh-my-zsh/custom/plugins/zsh-ssh" = {
        source = pkgs.fetchFromGitHub {
          owner = "sunlei";
          repo = "zsh-ssh";
          rev = "master";
          sha256 = "sha256-lc3fRcM1IazuDRvlOmPEiHk5ddWalqsiNNKcOj8eUSs=";
        };
        recursive = true;
      };

     programs.zsh = {
       enable = true;
       enableCompletion = true;

       # Ensure OMZ uses the writable custom dir in $HOME, not the read-only store ( Solution 1 )
       #  deprecated: initExtraFirst = ''
       initContent = lib.mkBefore ''
                                    export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
                                  '';

       initExtra = ''
          if command -v tmux >/dev/null 2>&1; then
            case $- in
              *i*)
                if [ -z "$TMUX" ]; then
                  tmux attach -t default 2>/dev/null || tmux new -s default
                fi
              ;;
            esac
          fi
        '';

       # syntaxHighlighting.enable = true;
       zplug = {
         enable = true;
         plugins = [
           # Fast jump around
           # { name = "agkozak/zsh-z"; }

           # A collection of utility functions for Zsh
           # { name = "belak/zsh-utils"; }

           # Adds vi mode to Zsh, allowing modal editing
           # { name = "jeffreytse/zsh-vi-mode"; }

           # Suggests commands as you type based on history and completions
           {name = "zsh-users/zsh-autosuggestions";}

           # Reminds you to use commands you've forgotten
           {name = "MichaelAquilina/zsh-you-should-use";}

           # Fast syntax highlighting for Zsh
           {name = "zdharma-continuum/fast-syntax-highlighting";}

           # Better history search
           {name = "zsh-users/zsh-history-substring-search";}

           # Auto-pairing of quotes, brackets, etc.
           {name = "hlissner/zsh-autopair";}
           # Directory listings with colors
           # { name = "supercrabtree/k"; }

           # Visual mode for Zsh
           { name = "b4b4r07/zsh-vimode-visual"; }
         ];
       };

       oh-my-zsh = {
         enable = true;
         plugins = [
           "git"
           "docker"
           "branch"
           "zsh-ssh"
         ];
       };

    shellAliases = {
      cd = "z";
      vim = "nvim";
      v = "nvim";
      e = "exit";
      c = "clear";
      cs = "sudo nix-store --gc";
      ll = "ls -la";
      cat = "bat";
      nxup = "cd ~/win-toolbox/nixos && git pull && sudo nixos-rebuild switch --flake .#foundation";
      dwup = "cd ~/Work/win-toolbox/nixos && git pull && sudo darwin-rebuild switch --flake .#darwin";
      gitCommitUndo = "git reset --soft HEAD\\^";
      # nix garbage collect
      ncg = "nix-collect-garbage --delete-older-than 3d && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      nc = "nix flake check";
      nt = "nix flake test";
    };
    history.size = 10000;
    history.path = "${config.home.homeDirectory}/.zsh_history";
  };
}
