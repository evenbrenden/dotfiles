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
        musnix.nixosModules.musnix
        nix-config
        nixpkgs-config
      ];
      home-manager-config-module.home-manager = {
        backupFileExtension = "backup";
        extraSpecialArgs = {
          sops-nix = sops-nix.homeManagerModules.sops;
          inherit username;
        };
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${username} = import ./home/home.nix;
      };
      nix-config = import ./nix.nix { inherit nixpkgs-stable nixpkgs-unstable; };
      nixpkgs-config = import ./nixpkgs/nixpkgs.nix { inherit i3quo nixpkgs-unstable system; };
      system = "x86_64-linux";
      username = "evenbrenden";
    in {
      nixosConfigurations = {
        naxos = nixpkgs-stable.lib.nixosSystem {
          modules = common-modules ++ [ (import ./nixos/naxos/configuration.nix username) ];
          inherit system;
        };
        work = nixpkgs-stable.lib.nixosSystem {
          modules = common-modules ++ [ (import ./nixos/work/configuration.nix username) ];
          inherit system;
        };
      };
    };
}
