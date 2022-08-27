{
  description = "evenbrenden/dotfiles";

  # nix flake update
  inputs = {
    # nix flake lock --update-input [input]
    nixpkgs-stable.url = "nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs-stable";
  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, home-manager, musnix, ... }:
    let
      system = "x86_64-linux";
      stateVersion = "22.05";
      # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/3
      pkgs = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
        overlays = [ overlay-unstable ];
      };
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      pinned-nixpkgs = { nix.registry.nixpkgs.flake = nixpkgs-stable; };
      utils = import ./utils.nix {
        pkgs = pkgs;
        home-manager = home-manager;
        system = system;
        stateVersion = stateVersion;
      };
    in {
      # sudo nixos-rebuild switch --flake path:$(pwd)#[configuration]
      nixosConfigurations = {
        gaucho = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/gaucho/configuration.nix
            pinned-nixpkgs
            musnix.nixosModules.musnix
          ];
        };
        naxos = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = [ ./nixos/naxos/configuration.nix pinned-nixpkgs ];
        };
        work = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/work/configuration.nix
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [ overlay-unstable ];
            })
            pinned-nixpkgs
          ];
        };
      };
      # home-manager switch --flake path:$(pwd)#[user]-[label]
      homeConfigurations = let
        users = [ "evenbrenden" ];
        configs = [
          {
            label = "linux";
            config = ./home/home.nix;
            extraModules = [{ targets.genericLinux.enable = true; }];
          }
          {
            label = "nixos";
            config = ./home/home.nix;
            extraModules = [ ];
          }
        ];
      in utils.mkHomeConfigs users configs;
    };
}
