{
  description = "evenbrenden/dotfiles";

  # nix flake update
  inputs = {
    # nix flake lock --update-input <input>
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs-stable";
    i3quo.url = "git+https://codeberg.org/evenbrenden/i3quo";
    i3quo.inputs.nixpkgs.follows = "nixpkgs-stable";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, home-manager, musnix, i3quo, sops-nix, ... }:
    let
      nix-config-module = {
        nix = {
          nixPath = [ "nixpkgs=${nixpkgs-stable}" "unstable=${nixpkgs-unstable}" ];
          registry = {
            # nixpkgs.flake = nixpkgs-stable; is already set
            unstable.flake = nixpkgs-unstable;
          };
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
            sof-firmware = with prev;
              import ./nixos/naxos/sof-firmware.nix {
                inherit fetchurl;
                inherit lib;
                inherit stdenvNoCC;
              };
            # https://github.com/NixOS/nixpkgs/issues/376743
            veracrypt = prev.veracrypt.overrideAttrs (finalAttrs: prevAttrs: rec {
              pname = "veracrypt";
              version = "1.26.15";
              src = prev.fetchurl {
                url = "https://launchpad.net/veracrypt/trunk/${version}/+download/VeraCrypt_${version}_Source.tar.bz2";
                hash = "sha256-upcCUDDiG5sjMbfrCJcBFjwyr0t+BFNfM1uvjXSnSRY=";
              };
            });
            vimPlugins = prev.vimPlugins // {
              avante-nvim = final.unstable.vimPlugins.avante-nvim.overrideAttrs (finalAttrs: prevAttrs: rec {
                pname = "avante.nvim";
                version = "0.0.19";
                src = prev.fetchFromGitHub {
                  owner = "yetone";
                  repo = "avante.nvim";
                  tag = "v${version}";
                  hash = "sha256-/WvkMsyhaYa3TLOg6QBVz1dvHO4vr1PdeSF7zVIOUcY=";
                };
              });
            };
          })
          i3quo.overlay
        ];
      };
      home-manager-config-module.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.evenbrenden = import ./home/home.nix;
        extraSpecialArgs = { sops-nix = sops-nix.homeManagerModules.sops; };
        backupFileExtension = "backup";
      };
      common-modules =
        [ nix-config-module nixpkgs-overlays-module home-manager.nixosModules.home-manager home-manager-config-module ];
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
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
