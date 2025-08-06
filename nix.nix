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
  };
}
