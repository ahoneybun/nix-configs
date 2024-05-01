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
    "arm64.nopauth"
  ];

  networking.hostName = "drack";

  services.udev.extraRules = ''
    # Enable touchscreen on X13s
    ACTION=="add", SUBSYSTEM=="drivers", KERNEL=="i2c_hid_of", ATTR{bind}="4-0010"
    # Set wifi MAC on X13s
    SUBSYSTEM=="net", ACTION=="add", ATTRS{vendor}=="0x17cb", ATTRS{device}=="0x1103", PROGRAM="/usr/share/ubuntu-x13s-settings/set-wifi-mac-addr %k"
  '';

}
