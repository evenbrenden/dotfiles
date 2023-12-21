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
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, home-manager, musnix, i3quo, attic, sops-nix, ... }:
    let
      nix-config-module = {
        nix = {
          # https://discourse.nixos.org/t/nix-run-refuses-to-evaluate-unfree-packages-even-though-allowunfree-true-in-my-config/13653/5
          nixPath = [ "nixpkgs=${nixpkgs-unstable}" ];
          registry.nixpkgs.flake = nixpkgs-unstable;
        };
      };
      nixpkgs-overlays-module = {
        nixpkgs.overlays = [
          (final: prev: {
            # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/3
            unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
            # https://github.com/NixOS/nixpkgs/pull/182069#issuecomment-1213432500
            firefox = prev.firefox.overrideAttrs
              (old: { libs = old.libs + ":" + prev.lib.makeLibraryPath [ prev.nss_latest ]; });
          })
          i3quo.overlay
          attic.overlays.default
        ];
      };
      home-manager-config-module.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.evenbrenden = import ./home/home.nix;
        extraSpecialArgs = { sops-nix = sops-nix.homeManagerModules.sops; };
      };
      common-modules =
        [ nix-config-module nixpkgs-overlays-module home-manager.nixosModules.home-manager home-manager-config-module ];
      system = "x86_64-linux";
    in {
      # sudo -EH nixos-rebuild switch --flake .#[configuration]
      nixosConfigurations = {
        gaucho = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = common-modules ++ [ ./nixos/gaucho/configuration.nix musnix.nixosModules.musnix ];
        };
        naxos = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = common-modules ++ [ ./nixos/naxos/configuration.nix musnix.nixosModules.musnix ];
        };
        work = nixpkgs-stable.lib.nixosSystem {
          inherit system;
          modules = common-modules ++ [ ./nixos/work/configuration.nix ];
        };
      };
    };
}
