{ nixpkgs-stable }:

{ pkgs, ... }:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    nixPath = [ "nixpkgs=${nixpkgs-stable}" ];
    package = pkgs.nixVersions.stable;
    registry.nixpkgs.flake = nixpkgs-stable;
    # haskell.nix
    settings = {
      trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
      substituters = [ "https://cache.iog.io" ];
    };
  };
}
