{ pkgs, ... }:

{
  home.packages = with pkgs; [ conan google-cloud-sdk meld pre-commit roomeqwizard usbutils ];

  programs.ssh.extraConfig = pkgs.lib.strings.concatStringsSep "\n" [
    (builtins.readFile "${pkgs.huddly}/ssh/icelocal")
    (builtins.readFile "${pkgs.huddly}/ssh/labor")
  ];
}
