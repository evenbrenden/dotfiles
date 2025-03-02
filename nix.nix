{ nixpkgs-stable, nixpkgs-unstable }:

{ pkgs, ... }:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    nixPath = [ "nixpkgs=${nixpkgs-stable}" "unstable=${nixpkgs-unstable}" ];
    package = pkgs.nixVersions.stable;
    registry = {
      nixpkgs.flake = nixpkgs-stable;
      unstable.flake = nixpkgs-unstable;
    };
    # haskell.nix
    settings = {
      trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
      substituters = [ "https://cache.iog.io" ];
    };
  };
}
