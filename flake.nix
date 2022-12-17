{
  description = "evenbrenden/dotfiles";

  # nix flake update
  inputs = {
    # nix flake lock --update-input [input]
    nixpkgs-stable.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs-stable";
    i3quo.url = "git+https://codeberg.org/evenbrenden/i3quo";
    i3quo.inputs.nixpkgs.follows = "nixpkgs-stable";
  };

  outputs =
    { nixpkgs-stable, nixpkgs-unstable, home-manager, musnix, i3quo, ... }:
    let
      system = "x86_64-linux";
      # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/3
      pkgs = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
        overlays = [ overlay-i3quo overlay-unstable ];
      };
      overlay-i3quo = (_: _: { i3quo = i3quo.packages.${system}.default; });
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
      # home-manager switch --flake .#evenbrenden
      homeConfigurations.evenbrenden =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              home = rec {
                username = "evenbrenden";
                homeDirectory = "/home/${username}";
                stateVersion = "22.05";
              };
            }
            ./home/home.nix
          ];
        };
    };
}
