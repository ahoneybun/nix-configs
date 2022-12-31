# nix-configs

This holds my .nix files for NixOS

Nix files: (nix-configs/)

- `configuration.nix` : This is the main file for the base system including some applications that I use
- `plasma.nix` : This file is for the desktop, login manager and other KDE applications
- `gnome.nix` : This file is for the desktop and login manager
- `programs.nix` : This file adds applications like Slack, Discord and virt-manager including turning on the services
- `unstable.nix` : This file has the applications that need to be from unstable to work like ProtonVPN software

Nix files: (nix-configs/systems)

## Use the nixos-hardware channel for Pinebook Pro and Raspberry Pi 4:

```
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --update
```

- `hp-omen.nix` : This file is mainly for my HP Omen to add and enable the NVIDIA driver from stable
- `linode.nix` : This file is for a Linode instance though it might work for other server setups
- `oryp6.nix` : This file is mainly for my System76 Oryx Pro (oryp6) to add and enable the NVIDIA driver from stable
- `rpi4.nix` : This file is to configure a Raspberry Pi 4B
- `pbp.nix` : This file is to configure a PineBook Pro
- `pinephone.nix` : This file is to configure a PinePhone

Nix files: (nix-configs/dev)

- `lamp.nix` : This file is a WIP for LAMP setup. 
