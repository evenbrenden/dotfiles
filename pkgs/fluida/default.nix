{ cairo,
  fetchFromGitHub,
  fluidsynth,
  lv2,
  pkgconfig,
  stdenv,
  unixtools,
  xorg }:

stdenv.mkDerivation rec {
  pname = "Fluida.lv2";
  version = "0.7";

  src = fetchFromGitHub {
    owner = "brummer10";
    repo = "Fluida.lv2";
    rev = "v${version}";
    sha256 = "1xp6rarjk3i01208qv6rw53zg4a3qq07i6ra2i2prbmgswmz1xlz";
    fetchSubmodules = true;
  };

  buildPhase = ''
    export HOME=$TEMPDIR
    make
  '';

  installPhase = ''
    mkdir -p $out/lib/lv2
    substituteInPlace ./Fluida/Makefile \
      --replace "INSTALL_DIR = ~/.lv2" "INSTALL_DIR = $out/lib/lv2"
    make install
  '';

  buildInputs = [
    cairo
    fluidsynth
    lv2
    pkgconfig
    unixtools.xxd
    xorg.libX11
  ];
}
