{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.checkJournalingFS = false;

  networking.hostName = "naxos";
  networking.wireless.enable = true;

  security.rngd.enable = false;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    unzip
    vim
    firefox
    git
    linuxPackages.virtualboxGuestAdditions
    llvmPackages.libclang
    libsForQt5.vlc
    vscode
    insync
  ];

  system.activationScripts = with pkgs;
    let
      src = fetchFromGitHub {
        owner = "evenbrenden";
        repo = "runcom";
        rev = "e7cbf1491b5b779139bd16d6a186de7269b2c581";
        sha256 = "0zdjq88nlq34vxvg23cd29dmas23zrvsk8cwliij0ksyhi2c6r0j";
      };
    in
    {
      dotfiles = {
        text =
          ''
          USER=evenbrenden
          DEST=/home/$USER
          SRC="${src}"
          cp $SRC/bashrc $DEST/.bashrc
          cp $SRC/gitconfig $DEST/.gitconfig
          '';
        deps = [];
      };
    };

  nix.gc.automatic = true;
  nix.gc.dates = "04:00";

  i18n = {
    consoleFont = "Lat2-Terminus16";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Amsterdam";

  users.users.evenbrenden = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.xserver.enable = true;
  services.xserver.layout = "us,no";
  services.xserver.resolutions = [ { x = 1680; y = 1050; } ];

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.libinput.enable = true;
  services.xserver.libinput.tapping = true;

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
