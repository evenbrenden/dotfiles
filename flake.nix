{
  description = "evenbrenden/dotfiles";

  inputs = {
    i3quo.url = "git+https://codeberg.org/evenbrenden/i3quo";
    i3quo.inputs.nixpkgs.follows = "nixpkgs-stable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs-stable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { i3quo, home-manager, musnix, nixpkgs-stable, nixpkgs-unstable, sops-nix, ... }:
    let
      home-manager-config-module = username: {
        home-manager = {
          backupFileExtension = "backup";
          extraSpecialArgs = {
            sops-nix = sops-nix.homeManagerModules.sops;
            inherit username;
          };
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username} = import ./home/home.nix;
        };
      };
      nix-config = import ./nix.nix { inherit nixpkgs-stable; };
      nixpkgs-config = import ./nixpkgs/nixpkgs.nix { inherit i3quo nixpkgs-unstable system; };
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        naxos = let username = "evenbrenden";
        in nixpkgs-stable.lib.nixosSystem {
          modules = [
            (import ./nixos/naxos/configuration.nix username)
            (home-manager-config-module username)
            home-manager.nixosModules.home-manager
            musnix.nixosModules.musnix
            nix-config
            nixpkgs-config
          ];
          inherit system;
        };
        labor = let username = "evenbrenden";
        in nixpkgs-stable.lib.nixosSystem {
          modules = [
            (import ./nixos/labor/configuration.nix username)
            (home-manager-config-module username)
            home-manager.nixosModules.home-manager
            musnix.nixosModules.musnix
            nix-config
            nixpkgs-config
          ];
          inherit system;
        };
      };
    };
}
