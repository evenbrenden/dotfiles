(self: super: {
  discord = super.discord.overrideAttrs (_: rec {

    pname = "metals";
    version = "0.11.10";

    deps = super.stdenv.mkDerivation {
      name = "${pname}-deps-${version}";
      buildCommand = ''
        export COURSIER_CACHE=$(pwd)
        ${super.coursier}/bin/cs fetch org.scalameta:metals_2.13:${version} \
          -r bintray:scalacenter/releases \
          -r sonatype:snapshots > deps
        mkdir -p $out/share/java
        cp -n $(< deps) $out/share/java/
      '';
      outputHashMode = "recursive";
      outputHashAlgo = "sha256";
      outputHash = "sha256-CNLBDsyiEOmMGA9r8eU+3z75VYps21kHnLpB1LYC7W4=";
    };
  });
})
