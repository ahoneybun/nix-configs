{ config, pkgs, lib, ... }:

{
  imports =
    [
        ./hardware-configuration.nix
    ];

  boot.kernelParams = [ "console=tty0" ];

  networking.hostName = "drack";

}
