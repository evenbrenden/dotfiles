{ pkgs }:

pkgs.xorg.xkeyboardconfig.overrideAttrs
(prevAttrs: { patches = (prevAttrs.patches or [ ]) ++ [ ./xkeyboardconfig-norwerty.patch ]; })
