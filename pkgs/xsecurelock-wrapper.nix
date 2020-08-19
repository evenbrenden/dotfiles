{ pkgs, stdenv }:

stdenv.mkDerivation {
  name = "xsecurelock-wrapper";
  buildInputs = [ pkgs.xsecurelock ];
  unpackPhase = ":";
  installPhase = ''
    install -m755 -D ${./xsecurelock-wrapper.sh} $out/bin/xsecurelock-wrapper
    substituteInPlace $out/bin/xsecurelock-wrapper --replace autorandr ${pkgs.autorandr}/bin/autorandr
    substituteInPlace $out/bin/xsecurelock-wrapper --replace xsecurelock ${pkgs.xsecurelock}/bin/xsecurelock
  '';
}

