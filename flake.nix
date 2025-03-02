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
      home-manager-config-module.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.evenbrenden = import ./home/home.nix;
        extraSpecialArgs = { sops-nix = sops-nix.homeManagerModules.sops; };
        backupFileExtension = "backup";
      };
      common-modules = [
        (import ./nix.nix { inherit nixpkgs-stable nixpkgs-unstable; })
        (import ./nixpkgs.nix { inherit system nixpkgs-unstable i3quo; })
        home-manager.nixosModules.home-manager
        home-manager-config-module
      ];
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
