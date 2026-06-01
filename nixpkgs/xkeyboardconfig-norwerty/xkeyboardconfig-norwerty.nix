{ pkgs }:

pkgs.xkeyboardconfig.overrideAttrs
(prevAttrs: { patches = (prevAttrs.patches or [ ]) ++ [ ./xkeyboardconfig-norwerty.patch ]; })
