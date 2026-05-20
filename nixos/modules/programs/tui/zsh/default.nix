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
          sha256 = "sha256-YEgJzbanZ7iRD9hV8Pn6Ns3Vj87mKnwZjO0VIhamnX4=";
        };
        recursive = true;
      };

     programs.zsh = {
       enable = true;
       enableCompletion = true;

       initContent = lib.mkBefore ''
          export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

          # Auto-attach to a default tmux session when starting an interactive shell
          # Darwin/macOS: do NOT auto-attach by default; only auto-attach when launched from Alacritty.
          # Other OS: auto-attach as before.
          if command -v tmux >/dev/null 2>&1; then
            case $- in
              *i*)
                if [ -z "$TMUX" ]; then
                  if [[ "$OSTYPE" == darwin* ]]; then
                    case "''${TERM:-}" in
                      alacritty)
                        tmux attach -t default 2>/dev/null || tmux new -s default
                      ;;
                      *)
                        # Do nothing for Apple Terminal
                      ;;
                    esac
                  else
                    tmux attach -t default 2>/dev/null || tmux new -s default
                  fi
                fi
              ;;
            esac
          fi

          # fzf-tab configuration with tmux popup integration
          # Use tmux popup for fzf interface when inside tmux (requires tmux >= 3.2)
          if [[ -n "$TMUX" ]]; then
            # Use fzf-tab's bundled helper to open a tmux popup for completion UI
            zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
          fi

          LS_COLORS="$LS_COLORS:ow=103;30;01"
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
           # { name = "b4b4r07/zsh-vimode-visual"; }

           # fzf-based completion plugin with rich UI (tmux popup supported)
           { name = "Aloxaf/fzf-tab"; }
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
      dwup = "cd ~/win-toolbox/nixos && git pull && sudo darwin-rebuild switch --flake .#darwin";
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
