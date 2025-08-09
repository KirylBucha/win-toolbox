{
  description = "Nix Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # Use the full default set (includes Darwin)
    systems.url = "github:nix-systems/default";
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    flake-utils.url = "github:numtide/flake-utils";

    # nix-darwin for macOS support (Keep input if you might use it later, even if no configs defined now)
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    systems,
    nixos-wsl,
    nixos-hardware,
    home-manager,
    darwin, # Keep this input if you anticipate defining macOS configs later
    ...
  }: let
    lib = nixpkgs.lib // home-manager.lib;
    # Support all major systems (Linux and Darwin)
    allSystems = import systems;
    forEachSystem = f: lib.genAttrs allSystems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs allSystems (
      system:
        import nixpkgs {
          inherit system;
          config = {allowUnfree = true;};
        }
    );
    vars = import ./config/vars.nix {inherit (nixpkgs) lib;};

    # Helper for home-manager module
    mkHomeManagerModule = {config, ...}: {
      home-manager = {
        useUserPackages = true;
        backupFileExtension = "backup";
        users.${vars.user.name} = {};
      };
    };
  in {
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    nixosConfigurations = {
      #   1-st Config
      foundation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs vars;
          outputs = self;
        };
        modules = [
          nixos-wsl.nixosModules.default
          ./hosts/pcs/foundation
          home-manager.nixosModules.home-manager
          mkHomeManagerModule
        ];
      };

      #   2-st Config
      darwin = nixpkgs.lib.nixosSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs vars;
          outputs = self;
        };
        modules = [
          nixos-wsl.nixosModules.default
          ./hosts/pcs/darwin
          home-manager.nixosModules.home-manager
          mkHomeManagerModule
        ];
      };

    };

    # The 'darwinConfigurations' block has been removed entirely because
    # there are no active macOS configurations.
    # The 'darwin' input is kept in 'inputs' section in case it's used later.
  };
}
