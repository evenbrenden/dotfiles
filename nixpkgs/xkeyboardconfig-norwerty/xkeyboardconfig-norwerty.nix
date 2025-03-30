{ pkgs }:

pkgs.xorg.xkeyboardconfig.overrideAttrs (prevAttrs: {
  nativeBuildInputs = prevAttrs.nativeBuildInputs ++ [ pkgs.automake ]; # Because xorg.xkeyboardconfig_custom does it
  patches = (prevAttrs.patches or [ ]) ++ [ ./xkeyboardconfig-norwerty.patch ];
})
