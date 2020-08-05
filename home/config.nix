let
  pinnedNixpkgs = import(builtins.fetchTarball {
    name = "nixos-unstable-a45f68ccac";
    url = "https://github.com/nixos/nixpkgs/archive/a45f68ccac476dc37ddf294530538f2f2cce5a92.tar.gz";
    sha256 = "0i19mrky9m73i601hczyfk25qqyr3j75idb72imdz55szc4vavzc";
  }) {};
in
  {
    allowUnfree = true;
    chromium.enableWideVine = true;
  }
