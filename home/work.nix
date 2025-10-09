{ pkgs, ... }:

{
  home.packages = with pkgs; [
    conan
    google-cloud-sdk
    libqalculate
    meld
    netron
    pre-commit
    roomeqwizard
    usbutils
    unstable.uv
  ];

  programs.ssh.includes = [ "${pkgs.huddly}/ssh/icefish" "${pkgs.huddly}/ssh/labor" ];
}
