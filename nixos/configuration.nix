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
        rev = "64ea0a6f71bf8a5b80909c9ba197fa79645db63b":
        sha256 = "1h80xxs97r9w3x8z2w4n23wvzd9ifccajbfvg859pyz3z6skk7wx";
      };
    in
    {
      dotfiles = {
        text =
          ''
          USER=evenbrenden
          DEST=/home/$USER
          SRC="${src}"
          cp $SRC/bashrc_common $DEST/.bashrc_common
          cp $SRC/gitconfig $DEST/.gitconfig
          cp $SRC/gitignore $DEST/.gitignore
          cp $SRC/vimrc $DEST/.vimrc
          cp $SRC/nixos/bashrc $DEST/.bashrc
          cp -r $SRC/nixos/config/ $DEST/.config/
          cp -r $SRC/nixos/local/ $DEST/.local/
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
