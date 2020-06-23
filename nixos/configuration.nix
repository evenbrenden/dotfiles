{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.luks.devices = {
      root = {
        device = "/dev/nvme0n1p1";
        preLVM = true;
        allowDiscards = true;
      };
    };
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 50;
      };
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 524288;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelPatches = [
      {
        name = "alsa-hda-realtek-fix-1";
        patch = ./0001-ALSA-hda-realtek-Fix-Lenovo-Thinkpad-X1-Carbon-7th-q.patch;
      }
      {
        name = "alsa-hda-realtek-fix-2";
        patch = ./0002-ALSA-hda-realtek-Replace-Lenovo-Thinkpad-X1-Carbon-7.patch;
      }
    ];
    supportedFilesystems = [ "ntfs" ];
  };

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  networking = {
    hostName = "naxos";
    networkmanager.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true; # Explicit PulseAudio support in applications

  hardware = {
    bluetooth.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  systemd.services = {
    headphones-clicks-fix = {
      description = "Headphones clicks fix";
      documentation = [ "https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3154512" ];
      script = ''
        hda-verb /dev/snd/hwC0D0 0x1d SET_PIN_WIDGET_CONTROL 0x0
      '';
      path = [ pkgs.alsaTools ];
      after = [ "multi-user.target" ];
      wantedBy = [ "sound.target" ];
    };
  };
  systemd.user.services = {
    set-pulseaudio-sink-port = {
      description = "Set pulseaudio sink port";
      script = ''
        python3 ${./set_pulseaudio_sink_port.py}
      '';
      path = [ pkgs.pulseaudio pkgs.python3 ];
      after = [ "default.target" ];
      wantedBy = [ "pulseaudio.service" ];
    };
    jiggle-mic-mute-led = {
      description = "Jiggle mic mute LED";
      script = ''
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
      '';
      path = [ pkgs.pulseaudio ];
      after = [ "default.target" ];
      wantedBy = [ "pulseaudio.service" ];
    };

  };

  nixpkgs.overlays = [
    (import ../overlays/jetbrains_old.nix)
    (import ../overlays/pulseaudio.nix)
    (import ../overlays/sof-firmware.nix)
    (import ../overlays/alsa-ucm-conf.nix)
  ];

  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };

  environment = {
    systemPackages = with pkgs; [
      abcde
      alsaTools
      arandr
      autorandr
      brightnessctl
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
      hsetroot
      irssi
      jetbrains.rider
      networkmanagerapplet
      libnotify
      libsForQt5.vlc
      linuxConsoleTools
      nomacs
      playerctl
      postman
      python3
      python37Packages.virtualenv
      rclone
      remmina
      sakura
      shellcheck
      slack
      spotify
      dotnet-sdk_3
      jotta-cli
      teams
      unzip
      veracrypt
      vscode
      xorg.xdpyinfo
    ];
  };

  virtualisation.virtualbox.host = {
    enableExtensionPack = true;
    enable = true;
  };

  programs.ssh.startAgent = true;

  nix.gc.automatic = true;
  nix.gc.dates = "04:00";

  time.timeZone = "Europe/Amsterdam";

  users.users.evenbrenden = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };

  services = {
    dbus.socketActivated = true;
    openssh.enable = false;
    picom.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      dpi = 144;
      libinput = {
        enable = true;
        tapping = true;
      };
      displayManager = {
        defaultSession = "none+i3";
        lightdm = {
          autoLogin.enable = true;
          autoLogin.user = "evenbrenden";
          background = "#000000";
          greeters.gtk.indicators = [ "~host" "~spacer" "~session" "~language" "~clock" "~power" ];
        };
        # Because xsetroot does not work with Picom
        sessionCommands = ''
            hsetroot -solid #000000
        '';
      };
      windowManager.i3.enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
    };
  };

  system.stateVersion = "20.03";
}
