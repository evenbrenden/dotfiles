{ pkgs, username }:

{
  # Docker
  virtualisation.docker.enable = true;

  # libvirt
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  programs.virt-manager = {
    enable = true;
    # https://github.com/NixOS/nixpkgs/issues/267579#issuecomment-1815519722
    package = with pkgs;
      (virt-manager.overrideAttrs (old: {
        nativeBuildInputs = old.nativeBuildInputs ++ [ wrapGAppsHook ];
        buildInputs = lib.lists.subtractLists [ wrapGAppsHook ] old.buildInputs
          ++ [ gst_all_1.gst-plugins-base gst_all_1.gst-plugins-good ];
      }));
  };

  # Groups
  users.users.${username}.extraGroups = [ "docker" "libvirtd" ];
}
