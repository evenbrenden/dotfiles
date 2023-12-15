{
  description = "evenbrenden/dotfiles";

  # nix flake update
  inputs = {
    # nix flake lock --update-input [input]
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs-stable";
    i3quo.url = "git+https://codeberg.org/evenbrenden/i3quo";
    i3quo.inputs.nixpkgs.follows = "nixpkgs-stable";
    attic.url = "github:zhaofengli/attic";
  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, home-manager, musnix, i3quo, attic, ... }:
    let
      system = "x86_64-linux";
      # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/3
      pkgs = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
        overlays = common-overlays;
      };
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      common-overlays = [
        i3quo.overlay
        overlay-unstable
        attic.overlays.default
        # https://github.com/NixOS/nixpkgs/pull/182069#issuecomment-1213432500
        (self: super: {
          firefox = super.firefox.overrideAttrs
            (old: { libs = old.libs + ":" + pkgs.lib.makeLibraryPath [ pkgs.nss_latest ]; });
        })
      ];
      # https://discourse.nixos.org/t/nix-run-refuses-to-evaluate-unfree-packages-even-though-allowunfree-true-in-my-config/13653/5
      nix-settings = {
        nix = {
          nixPath = [ "nixpkgs=${nixpkgs-unstable}" ];
          registry.nixpkgs.flake = nixpkgs-unstable;
        };
      };
    in {
      # sudo -EH nixos-rebuild switch --flake .#[configuration]
      nixosConfigurations = let commonModules = [ nix-settings { nixpkgs.overlays = common-overlays; } ];
      in {
        gaucho = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = commonModules ++ [ ./nixos/gaucho/configuration.nix musnix.nixosModules.musnix ];
        };
        naxos = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = commonModules ++ [ ./nixos/naxos/configuration.nix musnix.nixosModules.musnix ];
        };
        work = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = commonModules ++ [ ./nixos/work/configuration.nix ];
        };
      };
      # home-manager switch --flake .#[username]
      homeConfigurations.evenbrenden = home-manager.lib.homeManagerConfiguration {
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
