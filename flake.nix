{
  description = "evenbrenden/dotfiles";

  inputs = {
    i3quo.url = "git+https://codeberg.org/evenbrenden/i3quo";
    i3quo.inputs.nixpkgs.follows = "nixpkgs-stable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs-stable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { i3quo, home-manager, musnix, nixpkgs-stable, nixpkgs-unstable, sops-nix, ... }:
    let
      common-modules = [
        home-manager-config-module
        home-manager.nixosModules.home-manager
        (import ./nix.nix { inherit nixpkgs-stable nixpkgs-unstable; })
        (import ./nixpkgs.nix { inherit system nixpkgs-unstable i3quo; })
      ];
      home-manager-config-module.home-manager = {
        backupFileExtension = "backup";
        extraSpecialArgs = { sops-nix = sops-nix.homeManagerModules.sops; };
        useGlobalPkgs = true;
        useUserPackages = true;
        users.evenbrenden = import ./home/home.nix;
      };
      system = "x86_64-linux";
    in {
      formatter.${system} = import ./formatter.nix { pkgs = nixpkgs-stable.legacyPackages.${system}; }; # nix fmt
      nixosConfigurations = {
        naxos = nixpkgs-stable.lib.nixosSystem {
          modules = common-modules ++ [ ./nixos/naxos/configuration.nix musnix.nixosModules.musnix ];
          inherit system;
        };
        work = nixpkgs-stable.lib.nixosSystem {
          modules = common-modules ++ [ ./nixos/work/configuration.nix ];
          inherit system;
        };
      };
    };
}
