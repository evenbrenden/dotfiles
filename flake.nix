{
  description = "evenbrenden/dotfiles";

  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs/d9794b04bffb468b886c553557489977ae5f4c65";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      stateVersion = "22.05";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      utils = import ./utils.nix {
        pkgs = pkgs;
        home-manager = home-manager;
        system = system;
        stateVersion = stateVersion;
      };
    in {
      nixosConfigurations = {
        # sudo nixos-rebuild switch --flake path:$(pwd)#[configuration]
        gaucho = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./nixos/gaucho/configuration.nix ];
        };
        naxos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./nixos/naxos/configuration.nix ];
        };
        work = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./work/nixos/configuration.nix ];
        };
      };
      homeConfigurations = let
        # home-manager switch --flake path:$(pwd)#[user]-[configuration]
        users = [ "evenbrenden" (builtins.readFile ./work/names/workid) ];
        configs = [
          {
            label = "linux";
            config = import ./home/host-types/generic-linux.nix;
          }
          {
            label = "nixos";
            config = import ./home/host-types/nixos.nix;
          }
        ];
      in utils.mkHomeConfigs users configs;
    };
}
