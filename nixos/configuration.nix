{ config, pkgs, ... }:

let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sda3";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.checkJournalingFS = false;
  boot.loader.systemd-boot.configurationLimit = 120;

  networking.hostName = "naxos";
  networking.networkmanager.enable = true;

  security.rngd.enable = false;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true; # https://nixos.wiki/wiki/Xfce

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
    chromium.enableWideVine = true;
  };

  environment = {
    systemPackages = with pkgs; [
      abcde
      arandr
      autorandr
      cabal-install
      chromium
      curl
      dbeaver
      dos2unix
      dunst
      firefox
      gimp
      git
      gparted
      irssi
      jetbrains.rider
      unstable.jotta-cli
      networkmanagerapplet
      nomacs
      libnotify
      libsForQt5.vlc
      linuxConsoleTools
      postman
      python3
      python37Packages.virtualenv
      rclone
      remmina
      sakura
      shellcheck
      slack
      spotify
      unstable.dotnet-sdk_3
      unstable.teams
      unzip
      veracrypt
      virtualbox
      # virtualboxExtpack
      vscode
      xorg.xdpyinfo
    ];
    pathsToLink = [ "/libexec" ]; # For i3
  };

  programs.ssh.startAgent = true;

  nix.gc.automatic = true;
  nix.gc.dates = "04:00";

  i18n = {
    consoleFont = "Lat2-Terminus16";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Amsterdam";

  users.users.evenbrenden = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };

  services.xserver = {
    enable = true;
    layout = "us,no";
    libinput.enable = true;
    libinput.tapping = true;
    displayManager.lightdm = {
      background = "#000000";
      greeters.gtk.indicators = [ "~host" "~spacer" "~session" "~language" "~clock" "~power" ];
    };
    windowManager.i3.enable = true;
    desktopManager = {
      default = "xfce";
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
  };

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.haveged.enable = true;

  system.stateVersion = "20.03";
}
