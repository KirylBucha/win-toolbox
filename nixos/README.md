# NixOS

## Pre Configured Shell

We have a pre configured shell available, with all the required tooling. Simply run `$ nix-shell` and you have everything set up. This is powered by our `shell.nix` file, and is useful on a freshly installed NixOS machine.

## Useful Commands

I use [just](https://github.com/casey/just), a tool similar to Make, to help make commands more easily runnable. To install it, see [this documentation](https://github.com/casey/just?tab=readme-ov-file#packages). This is all powered by our `justfile`.

## How To Build/Deploy

`$ just deploy [machine name]`

See `flake.nix` for machine names, these are based off of `hosts/`.

## NixOS Pattern

1. Our usage of Just will leverage a `--flake` argument, passed by the CLI as an argument, indicating what machine we'll be building and deploying by pointing to a specific section in `flake.nix`.
2. Configuration variables are defined n `config/vars.nix`. These can be overridden by each `./hosts/`'s `default.nix`. This is done here, as we're using `flake.nix` for system level configurations.
3. The machine's `flake.nix` section will point to a `./hosts/[machine-name]`, which will resolve to `./hosts/[machine-name]/default.nix`.
4. That `./hosts/[machine-name]/default.nix` file will define system things, and point to that machine's `./hosts/[machine-name]/hardware-configuration.nix`, and any and all `./modules/` that are relevant for that machine. For example, like `./modules/home/default.nix` which defines user packages.

## To View Your NixOs Version

`$ nixos-version`

## How To Update To New Version

1. In your flake.nix, you need to update the following inputs:

```nix
nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
home-manager = {
  url = "github:nix-community/home-manager/release-24.11";
  inputs.nixpkgs.follows = "nixpkgs";
};
stylix.url = "github:danth/stylix/release-24.11";
```
2. Make sure that your `flake.nix`'s configuration for the target machine has a URL that looks like `nixpkgs-unstable.lib.nixosSystem`
// 3. Update your flake.lock file: `$ nix flake update`. This command can take a while.
4. Then rebuild your system: `$ just upgrade <host-name>`

