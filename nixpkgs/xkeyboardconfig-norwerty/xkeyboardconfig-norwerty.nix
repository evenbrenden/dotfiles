{ pkgs }:

pkgs.xorg.xkeyboardconfig.overrideAttrs
(_: previousAttrs: { patches = (previousAttrs.patches or [ ]) ++ [ ./base.xml.patch ./no.patch ]; })
