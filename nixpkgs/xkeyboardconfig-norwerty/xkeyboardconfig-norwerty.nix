{ pkgs }:

pkgs.xorg.xkeyboardconfig.overrideAttrs
(_: previousAttrs: { patches = (previousAttrs.patches or [ ]) ++ [ ./xkeyboardconfig-norwerty.patch ]; })
