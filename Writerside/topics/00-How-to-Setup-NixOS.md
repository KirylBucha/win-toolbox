# How to setup NixOS on WSL 2

## Overview

This guide explains how to NixOS on WSL 2.


## Set up WSL 2

### Enable WSL if you haven't done already:
```Bash
wsl --install --no-distribution
```

### Download nixos.wsl 

From the latest [release](https://github.com/nix-community/NixOS-WSL/releases/latest)

### Double-click the file

Open the file you just downloaded with .wsl extension (requires WSL >= 2.4.4).

Output:

![WSL2-NIXOS-Welcome-Screen.png](WSL2-NIXOS-Welcome-Screen.png)

### Check the version of NixOS

Check by [link](https://status.nixos.org/) the stable version of NixOS.

```nix
nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
home-manager = {
  url = "github:nix-community/home-manager/release-24.11";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

### Update and Rebuild
```Bash
sudo nix-channel --update 
sudo nixos-rebuild switch
```

## Configure NixOS for User Profile

### Create symlink to .ssh, .kube profiles

Create symlinks:
```Bash
sudo ln -sf "/mnt/c/Users/%default-user%/.ssh" $HOME
sudo ln -sf "/mnt/c/Users/%default-user%/.kube" $HOME
```

(Optional) Drop symlinks:
```Bash
rm $HOME/.ssh -rf
rm $HOME/.kube -rf
```

### Clone Toolbox repository

Install temporary tools:
```Bash
nix-shell -p git -p vim -p just
```

> **IMPORTANT**: A public SSH key is required to clone the repository.
>
{style="note"}

Clone repository:
```Bash
git clone git@github.com:KirylBucha/win-toolbox.git
```

### Install Toolbox
```Bash
cd /home/nixos/win-toolbox/nixos
sudo nixos-rebuild switch --flake .#foundation
```

### Update Toolbox from Repo
```Bash
cd /home/nixos/win-toolbox/nixos
git pull
sudo nixos-rebuild switch --flake .#foundation
```

## Troubleshooting: NixOS

In case of errors, try to restart WSL:
```Bash
   wsl -d NixOS --user root exit
   wsl -t NixOS
```

## Copy SSH Configs
TBD