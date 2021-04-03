{ stdenv,
  fetchFromGitHub,
  cmake,
  pkgconfig,
  cairo,
  gnome3,
  libjack2,
  libsndfile,
  libxkbcommon,
  xorg }:

stdenv.mkDerivation rec {
  pname = "sfizz";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "sfztools";
    repo = pname;
    rev = version;
    sha256 = "1aqhaip3xdnfbsh39avxwma6r8p561pcnhybplxdkcagw3kmh5yx";
    fetchSubmodules = true;
  };

  postPatch = ''
    substituteInPlace \
      ./editor/external/vstgui4/vstgui/lib/platform/linux/x11fileselector.cpp \
      --replace '/usr/bin/zenity' '${gnome3.zenity}/bin/zenity'
  '';

  nativeBuildInputs = [ cmake pkgconfig ];

  buildInputs = [
    cairo
    libjack2
    libsndfile
    libxkbcommon
    xorg.libX11
    xorg.xcbutil
    xorg.xcbutilcursor
    xorg.xcbutilkeysyms
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DSFIZZ_TESTS=ON"
  ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/sfztools/sfizz";
    description = "SFZ jack client and LV2 plugin";
    license = licenses.bsd2;
    maintainers = [ maintainers.magnetophon maintainers.evenbrenden ];
    platforms = platforms.all;
    badPlatforms = platforms.darwin;
  };
}
