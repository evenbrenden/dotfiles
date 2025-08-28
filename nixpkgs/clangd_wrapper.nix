{ pkgs }:

pkgs.python3Packages.buildPythonApplication {
  pname = "clangd_wrapper";
  version = "0.0.1";

  pyproject = false;

  propagatedBuildInputs = [ pkgs.clang-tools ];

  dontUnpack = true;

  installPhase = ''
    install -Dm755 "${./clangd_wrapper.py}" "$out/bin/clangd_wrapper"
  '';
}
