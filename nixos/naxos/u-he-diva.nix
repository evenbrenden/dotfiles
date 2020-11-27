{ stdenv, autoPatchelfHook, expat, libuuid, glib, gtk3 }:

stdenv.mkDerivation rec {
  name = "u-he-diva";
  src = ./Diva_144_9775_Linux.tar.xz;

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ expat libuuid glib gtk3 ];

  # Still need to run u-he-diva.sh to install GUI element images and presets
  # and such to ~/.u-he/ (because for some reason that is where the plugin
  # looks for things like that) until I figure out a better way to do it.
  installPhase = ''
    mkdir -p $out/lib/vst
    cp -r . $out/lib/vst
  '';
}
