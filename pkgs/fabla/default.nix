{ stdenv,
  fetchFromGitHub,
  cmake,
  pkgconfig,
  cairo,
  cairomm,
  libsndfile,
  lv2,
  ntk }:

stdenv.mkDerivation rec {
  pname = "fabla";
  version = "1.3.2";

  src = fetchFromGitHub {
    owner = "openAVproductions";
    repo = "openAV-fabla";
    rev = "7051261fc47f1b56f551f9e4128ceb70523ca3b8";
    sha256 = "0gnrszinfl8115p2y8gy3fh6mh3b2lk2a1aidp190bvmay5lc4h7";
  };

  nativeBuildInputs = [
    cmake
    pkgconfig
  ];

  buildInputs = [
    cairo
    cairomm
    libsndfile
    lv2
    ntk
  ];

  meta = with stdenv.lib; {
    description = "Fabla";
    homepage    = http://openavproductions.com/fabla/;
    license     = licenses.gpl2;
    maintainers = [ maintainers.evenbrenden ];
    platforms   = [ "x86_64-linux" ];
  };
}
