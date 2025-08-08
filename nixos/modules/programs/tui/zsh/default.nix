{
  vars,
  pkgs,
  ...
}:
let
  # Define our custom plugin sources using fetchFromGitHub
  zsh-ssh = pkgs.fetchFromGitHub {
    owner = "sunlei";
    repo = "zsh-ssh";
    rev = "master"; # Using a version tag, adjust if needed
    sha256 = "sha256-0RnRZhgBcZCjLXeGqKBkZmKQAZl3O7LiMgKqvgT8zGE="; # Replace with the correct hash
  };
in
{
     programs.zsh = {
       enable = true;
       enableCompletion = true;
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
#           {name = "zsh-users/zsh-autosuggestions";}

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
           { name = "zsh-ssh"; src = zsh-ssh; }
         ];
       };

    shellAliases = {
      vim = "nvim";
      v = "nvim";
      e = "exit";
      c = "clear";
      cs = "sudo nix-store --gc";
      ll = "ls -l";
      gitCommitUndo = "git reset --soft HEAD\\^";
      # nix garbage collect
      ncg = "nix-collect-garbage --delete-older-than 3d && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      nc = "nix flake check";
      nt = "nix flake test";
    };
    history.size = 10000;
    history.path = "/home/${vars.user.name}/.zsh_history";
  };
}
