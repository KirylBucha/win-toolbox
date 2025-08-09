# NixOS

## Pre Configured Shell

We have a pre configured shell available, with all the required tooling. Simply run `$ nix-shell` and you have everything set up. This is powered by our `shell.nix` file, and is useful on a freshly installed NixOS machine.

## To View Your NixOs Version

`$ nixos-version`

## How To Update To New Version

1. In your flake.nix, you need to update the following inputs:

```nix
nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
home-manager = {
  url = "github:nix-community/home-manager/release-24.11";
  inputs.nixpkgs.follows = "nixpkgs";
};
```
2. Make sure that your `flake.nix`'s configuration for the target machine has a URL that looks like `nixpkgs-unstable.lib.nixosSystem`
// 3. Update your flake.lock file: `$ nix flake update`. This command can take a while.
4. Then rebuild your system: `$ just upgrade <host-name>`

