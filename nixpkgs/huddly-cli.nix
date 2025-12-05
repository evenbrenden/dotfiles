{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "huddly";
  version = "2.28.3+a8091c20ae77332eb9a182a21afd62499a2230f1";

  src = pkgs.fetchurl {
    url = "https://huddlyreleaseserver.azurewebsites.net/download/ga/huddly-cli-linux-x64";
    hash = "sha256-YAEMNbwJmnOFGLuQJu3fR5Bl30PgV0bx46diyKcvuiY=";
  };

  nativeBuildInputs = with pkgs; [ autoPatchelfHook makeWrapper unzip ];

  buildInputs = with pkgs; [ libz stdenv.cc.cc ];

  dontBuild = true;
  dontStrip = true;

  unpackPhase = ''
    unzip $src
  '';

  installPhase = let runtimeDeps = with pkgs; lib.makeLibraryPath [ libusb1 openssl ];
  in ''
    unzipped="huddly"
    target="$out/bin"
    unwrapped="$target/huddly-unwrapped"
    wrapped="$target/huddly"

    mkdir -p "$target"
    cp "$unzipped" "$unwrapped"
    chmod +x "$unwrapped"

    makeWrapper "$unwrapped" "$wrapped" --set LD_LIBRARY_PATH "${runtimeDeps}"
  '';
}
