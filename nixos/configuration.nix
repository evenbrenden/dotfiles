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
        rev = "6c7cfded2a48dba58c96d259d754d269048a9138";
        sha256 = "1fiwmpx191mmhzsahx5zzx8fb0glngsfiss71r3rwq2lza907izm";
      };
    in
    {
      dotfiles = {
        text =
          ''
          USER=evenbrenden
          DEST=/home/$USER
          SRC="${src}"
          cp $SRC/nixos/bashrc $DEST/.bashrc
          cp $SRC/bashrc_common $DEST/.bashrc_common
          cp $SRC/gitconfig $DEST/.gitconfig
          cp $SRC/gitignore $DEST/.gitignore
          cp $SRC/vimrc $DEST/.vimrc
          cp -r $SRC/kde/config/ $DEST/.config/
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
