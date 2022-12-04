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
      # https://discourse.nixos.org/t/nix-run-refuses-to-evaluate-unfree-packages-even-though-allowunfree-true-in-my-config/13653/5
      nix-settings = {
        nix = {
          nixPath = [ "nixpkgs=${nixpkgs-unstable}" ];
          registry.nixpkgs.flake = nixpkgs-unstable;
        };
      };
      utils = import ./utils.nix {
        pkgs = pkgs;
        home-manager = home-manager;
        system = system;
        stateVersion = stateVersion;
      };
    in {
      # sudo nixos-rebuild switch --flake .#[configuration]
      nixosConfigurations = {
        gaucho = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/gaucho/configuration.nix
            musnix.nixosModules.musnix
            nix-settings
            { nixpkgs.pkgs = pkgs; }
          ];
        };
        naxos = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/naxos/configuration.nix
            nix-settings
            { nixpkgs.pkgs = pkgs; }
          ];
        };
        work = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/work/configuration.nix
            nix-settings
            { nixpkgs.pkgs = pkgs; }
          ];
        };
      };
      # home-manager switch --flake .#[user]-[label]
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
