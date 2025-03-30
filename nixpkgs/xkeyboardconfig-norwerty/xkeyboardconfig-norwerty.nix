{ pkgs }:

pkgs.xorg.xkeyboardconfig.overrideAttrs (_: previousAttrs: {
  nativeBuildInputs = previousAttrs.nativeBuildInputs
    ++ [ pkgs.automake ]; # Because xorg.xkeyboardconfig_custom does it
  patches = (previousAttrs.patches or [ ]) ++ [ ./xkeyboardconfig-norwerty.patch ];
})
