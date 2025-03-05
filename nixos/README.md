# Installing NixOS

1. [Download a graphical ISO image](https://nixos.org/download.html#nixos-iso) and create a stick with `dd if=[path to ISO image] of=[path to USB disk]`.
2. Disable Secure Boot.
3. Reboot and follow instructions. Encrypt drive and opt out of any desktop environment.
4. Restart and clone this repo.
5. Either add a new machine by merging and adjusting `/etc/nixos/` (and [this](https://github.com/NixOS/nixos-hardware)) or reuse an existing machine.
6. Switch configuration with `./switch [configuration]`.
