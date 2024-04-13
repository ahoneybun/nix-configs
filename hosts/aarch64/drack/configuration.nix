{ config, pkgs, lib, ... }:

{
  imports =
    [
        ./hardware-configuration.nix
    ];

  boot.kernelParams = [ 
    "console=tty0" 
    "clk_ignore_unused"
    "pd_ignore_unused"
  ];

  networking.hostName = "drack";

}
