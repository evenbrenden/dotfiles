{ config, pkgs, ... }:

let
  renoisePath = ./rns_324_linux_x86_64.tar.gz;
  hasRenoise = builtins.pathExists renoisePath;
in
{
  home.packages = with pkgs; [
    ardour
  ]
  ++
  (
    lib.lists.optional
    hasRenoise
    (renoise.override { releasePath = renoisePath; })
  );

  # Terrible workaround until I can figure out how to make the desktop item
  # supplied with the Renoise tarball to work when installed via the package
  xdg.dataFile =
    pkgs.lib.attrsets.optionalAttrs
    hasRenoise
    { "applications/renoise.desktop".source = ./renoise.desktop; };
}
