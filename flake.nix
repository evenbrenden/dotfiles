{
  description = "evenbrenden/dotfiles";

  inputs = {
    # Remove come Home Manager 26.11
    herdr = {
      url = "github:herdrdev/herdr/v0.9.5";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    i3quo = {
      url = "git+https://codeberg.org/evenbrenden/i3quo";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs-stable";
    nixpkgs-stable.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    {
      herdr,
      i3quo,
      home-manager,
      musnix,
      nixpkgs-stable,
      nixpkgs-unstable,
      sops-nix,
      ...
    }:
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
      nixpkgs-config = import ./nixpkgs/nixpkgs.nix {
        inherit
          herdr
          i3quo
          nixpkgs-unstable
          system
          ;
      };
      username = "evenbrenden";
      system = "x86_64-linux";
    in
    {
      formatter.${system} = nixpkgs-stable.legacyPackages.${system}.nixfmt-tree;
      nixosConfigurations = {
        naxos = nixpkgs-stable.lib.nixosSystem {
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
        labor = nixpkgs-stable.lib.nixosSystem {
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
