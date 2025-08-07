{
  vars,
  pkgs,
  ...
}: {
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
        {name = "zsh-users/zsh-autosuggestions";}

        # Reminds you to use commands you've forgotten
        #{name = "MichaelAquilina/zsh-you-should-use";}

        # Fast syntax highlighting for Zsh
        {name = "zdharma-continuum/fast-syntax-highlighting";}

        # Better history search
        #{name = "zsh-users/zsh-history-substring-search";}

        # Auto-pairing of quotes, brackets, etc.
        {name = "hlissner/zsh-autopair";}

        # Directory listings with colors
        # { name = "supercrabtree/k"; }

        # Visual mode for Zsh
        # { name = "b4b4r07/zsh-vimode-visual"; }
      ];
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "zsh-ssh"
      ];
    };

    # 2. Define your custom plugin here.
    customPlugins = {
      "zsh-ssh" = {
          # The name of the main plugin file.
          file = "zsh-ssh.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "sunlei";
            repo = "zsh-ssh";
            # It's best practice to use a specific commit hash for 'rev'.
            rev = "v0.9.0";
            # The correct sha256 for the rev above.
            sha256 = "17rby45q16z08h2q1a5gwpd49p0pcmn7jczwl5j7j56j1l6a1j17";
        };
      };
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
