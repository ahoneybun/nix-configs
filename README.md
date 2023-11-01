# nix-configs

This holds my .nix files for NixOS

## Main Nix files: (nix-configs)

These files are for the configuration, software that I use and unstable software that I use, note that some systems like the Pinebook Pro will use a custom configuration file.

- `configuration.nix` : This is the main file for the base system including some applications that I use
- `programs.nix` : This file adds applications like Slack, Discord and virt-manager including turning on the services
- `unstable.nix` : This file has the applications that need to be from unstable to work like ProtonVPN software

## Desktop Nix files: (nix-configs/desktops/)

These files are for the desktops (DE or WM) that I use at times.

- `plasma.nix` : This file is for the desktop, login manager and other KDE applications
- `gnome.nix` : This file is for the desktop and login manager
- `pantheon.nix` : This file is for the desktop and login manager (this removes AppCenter)
- `sway.nix` : This file is for the Sway WM

## System Nix files: (nix-configs/systems/)

These files are for the systems themselves such as my Pinebook Pro, Raspberry Pi 4B or HP Omen.

### x86_64 Nix files: (nix-configs/systems/x86_64/)

- `shepard.nix` : This file is for my custom desktop at home.
- `garrus.nix` : This file is for my System76 Galago Pro (galp3-b).
- `sovereign.nix` : This file is for a Linode instance but it could be for other VPS services as well.
- `harbinger.nix` : This file is for a Linode instance but it could be for other VPS services as well.

### aarch64 Nix files: (nix-configs/systems/aarch64/)

- `jaal.nix` : This file is for my Pinebook Pro.
- `peebee.nix` : This file is for my PinePhone.
- `vetra.nix` : This file is for my Pi 4B.

### Use the nixos-hardware channel for Pinebook Pro and Raspberry Pi 4:

```
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --update
```

## Shell Nix files: (nix-configs/shell/)

These files are for building software or for spinning something up like CUDA.

- `cuda-shell.nix` : This file setups CUDA (currently 11.7).
- `system-docs` : This is for building support.system76.com on NixOS for development.
- `COSMIC` : This is for building COSMIC on NixOS, there is no way to actually use it on NixOS though with how systemd works.

## Web Nix files: (nix-configs/web/)

These files are for websites such as LAMP and NGINX.

- `lamp.nix` : This file is a WIP for LAMP setup. 
- `ahoneybun-net.nix` : This file is a basic setup for my website (ahoneybun.net).
- `hydra-ahoneybun-net.nix` : This file is a NGINX reverse proxy for my [Hydra](https://github.com/NixOS/hydra) server pointing to the localhost.
- `cloud-ahoneybun-net.nix` : This file is for Nextcloud.
- `rockymtnlug-org.nix` : This file is for [RMLUG](https://rockymountainlinuxfest.org).
- `tildecafe-com.nix` : This file is for [Tildecafe](https://tildecafe.com).
- `stoners-space.nix` : This file is for Mastodon on my stoners.space domain, simple changes can be made for a different domain.
- `nginx-owncast.nix` : This file is a NGINX reverse proxy for [Owncast](https://owncast.online) though it is not currently working.

## Home Manager file: (nix-configs/home.nix)

This file is for using with [Home Manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone).


- `home.nix` : This file is for settings for my user like Git name/email and other settings

### Screenshots

![GNOME Installation](Screenshots/nixos-gnome.png)

![Pantheon Installation](Screenshots/nixos-pantheon.png)
