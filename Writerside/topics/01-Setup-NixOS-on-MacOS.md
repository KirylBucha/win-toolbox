# Setup NixOS on MacOS

## Overview

This guide explains how to NixOS on WSL 2.

## Set up NixOS

Follow the official guide [link](https://nixos.org/download/#nix-install-macos).

```Bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```
Follow the installation instructions.

### Check the version of NixOS

Check by [link](https://status.nixos.org/) the stable version of NixOS.

```text
nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
home-manager = {
  url = "github:nix-community/home-manager";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

### Clone Toolbox repository

Install temporary tools:
```Bash
nix-shell -p git
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
cd ~/win-toolbox/nixos
sudo nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake  .#darwin
```

### Update Toolbox from Repo
```Bash
cd ~/win-toolbox/nixos
git pull
sudo darwin-rebuild switch --flake .#darwin
```

## Copy SSH Configs
TBD