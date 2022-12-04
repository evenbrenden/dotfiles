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
    in {
      # sudo nixos-rebuild switch --flake .#[configuration]
      nixosConfigurations =
        let commonModules = [ nix-settings { nixpkgs.pkgs = pkgs; } ];
        in {
          gaucho = nixpkgs-stable.lib.nixosSystem {
            inherit system;
            modules = commonModules ++ [
              ./nixos/gaucho/configuration.nix
              musnix.nixosModules.musnix
            ];
          };
          naxos = nixpkgs-stable.lib.nixosSystem {
            inherit system;
            modules = commonModules ++ [ ./nixos/naxos/configuration.nix ];
          };
          work = nixpkgs-stable.lib.nixosSystem {
            inherit system;
            modules = commonModules ++ [ ./nixos/work/configuration.nix ];
          };
        };
      # home-manager switch --flake .#[configuration]
      homeConfigurations = let
        baseConfiguration = {
          inherit pkgs system;
          username = username;
          homeDirectory = "/home/${username}";
          configuration = ./home/home.nix;
        };
        username = "evenbrenden";
      in {
        linux = home-manager.lib.homeManagerConfiguration (baseConfiguration
          // {
            extraModules = [{ targets.genericLinux.enable = true; }];
          });
        nixos = home-manager.lib.homeManagerConfiguration baseConfiguration;
      };
    };
}
