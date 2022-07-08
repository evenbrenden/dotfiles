{
  description = "evenbrenden/dotfiles";

  # nix flake update
  inputs = {
    # nix flake lock --update-input nixpkgs
    nixpkgs.url = "nixpkgs/nixos-22.05";
    # nix flake lock --update-input home-manager
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nix flake lock --update-input musnix
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, musnix, ... }@inputs:
    let
      system = "x86_64-linux";
      stateVersion = "22.05";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      pinned-nixpkgs = { nix.registry.nixpkgs.flake = nixpkgs; };
      utils = import ./utils.nix {
        pkgs = pkgs;
        home-manager = home-manager;
        system = system;
        stateVersion = stateVersion;
      };
    in {
      # sudo nixos-rebuild switch --flake path:$(pwd)#[configuration]
      nixosConfigurations = {
        gaucho = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/gaucho/configuration.nix
            pinned-nixpkgs
            musnix.nixosModules.musnix
          ];
        };
        naxos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./nixos/naxos/configuration.nix pinned-nixpkgs ];
        };
        work = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./work/nixos/configuration.nix pinned-nixpkgs ];
        };
      };
      # home-manager switch --flake path:$(pwd)#[user]-[label]
      homeConfigurations = let
        users = [ "evenbrenden" (builtins.readFile ./work/names/workid) ];
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
