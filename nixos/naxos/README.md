### Installing NixOS on my ThinkPad X1 Carbon Gen 7

#### Sources
- https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134
- https://myme.no/posts/2019-07-01-nixos-into-the-deep-end.html
- https://chris-martin.org/2015/installing-nixos
- https://bluishcoder.co.nz/2014/05/14/installing-nixos-with-encrypted-root-on-thinkpad-w540.html
- https://nixos.org/nixos/manual/index.html#sec-installation

#### First things first
- Create installer USB with `dd if=nixos-minimal-20.03.1619.ab3adfe1c76-x86_64-linux.iso of=/dev/sda`
- Disable Secure Boot

#### All things disk
    # parted /dev/nvme0n1 -- mklabel gpt
    # parted /dev/nvme0n1 -- mkpart primary 512MiB 100%
    # parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
    # parted /dev/nvme0n1 -- set 2 boot on

    # cryptsetup luksFormat /dev/nvme0n1p1
    # cryptsetup luksOpen /dev/nvme0n1p1 enc-pv
    # pvcreate /dev/mapper/enc-pv
    # vgcreate vg /dev/mapper/enc-pv
    # lvcreate -L 16.5GiB -n swap vg
    # lvcreate -l '100%FREE' -n root vg

    # mkfs.ext4 -L [hostname] /dev/vg/root
    # mkswap -L swap /dev/vg/swap
    # mkfs.fat -F 32 -n BOOT /dev/nvme0n1p2

    # mount /dev/disk/by-label/[hostname] /mnt
    # mkdir -p /mnt/boot
    # mount /dev/disk/by-label/BOOT /mnt/boot

#### Need a network connection during install
- Create `/etc/wpa_supplicant.conf` with
  ```
  network={
    ssid="****"
    psk="****"
  }
  ```
- Start it up with `systemctl start wpa_supplicant.service`

#### Clone dotfiles
    # nix run nixos.git
    # git clone https://github.com/evenbrenden/dotfiles

#### Configure
- Run `# nixos-generate-config --dir .` and compare with `dotfiles`

#### Install
    # nixos-install \
      -I nixos-config=dotfiles/nixos/[hostname]/configuration.nix \
      -I nixpkgs=$(cat dotfiles/nixos-nixpkgs.url)
