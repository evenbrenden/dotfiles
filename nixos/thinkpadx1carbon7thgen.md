* https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134
* https://myme.no/posts/2019-07-01-nixos-into-the-deep-end.html#fnref4
* https://nixos.org/nixos/manual/index.html#sec-installation

* Update Lenovo firmware using pre-installed Windows
* `dd if=nixos-minimal-20.03.1619.ab3adfe1c76-x86_64-linux.iso of=/dev/sda`
* Disable Secure Boot

* `parted /dev/sda -- mklabel gpt`
* `parted /dev/sda -- mkpart primary 512MiB -17GiB`
* `parted /dev/sda -- mkpart primary linux-swap -17GiB 100%`
* `parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB`
* `parted /dev/sda -- set 3 boot on`

* `cryptsetup luksFormat /dev/sda1`
* `cryptsetup luksOpen /dev/sda1 enc-pv`
* `pvcreate /dev/mapper/enc-pv`
* `vgcreate vg /dev/mapper/enc-pv`
* `lvcreate -L 17G -n swap vg`
* `lvcreate -l '100%FREE' -n root vg`

* `mkfs.ext4 -L naxos /dev/sda1`
* `mkswap -L swap /dev/sda2`
* `mkfs.fat -F 32 -n boot /dev/sda3`

* `mount /dev/disk/by-label/naxos /mnt`
* `mkdir -p /mnt/boot`
* `mount /dev/disk/by-label/boot /mnt/boot`

* Add
  ```
  network={
    ssid="****"
    psk="****"
  }
  ```
  to `/etc/wpa_supplicant.conf`
* `systemctl start wpa_supplicant`

* `sudo nixos-generate-config --root /mnt`
* `nix-env -iA nixos.git`
* `git clone https://github.com/evenbrenden/dotfiles`
* `sudo cp dotfiles/nixos/configuration.nix /mnt/etc/nixos/configuration.nix`
* `sudo nixos-install`
