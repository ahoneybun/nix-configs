{ config, pkgs, lib, ... }:

{
  imports =
    [
#        <nixos-hardware/pine64/pinebook-pro>
        ./hardware-configuration.nix
#       ./programs.nix
    ];

  boot.kernelParams = [ "console=tty0" ];

  boot.loader = {
    efi = {
    canTouchEfiVariables = false;
  };

  grub = {
    enable = true;
    efiInstallAsRemovable = true;
    efiSupport = true;
    version = 2;
    device = "nodev";
    };
  };

  boot.initrd.kernelModules = [
    # Rockchip modules
    "rockchip_rga"
    "rockchip_saradc"
    "rockchip_thermal"
    "rockchipdrm"

    # GPU/Display modules
    "analogix_dp"
    "cec"
    "drm"
    "drm_kms_helper"
    "dw_hdmi"
    "dw_mipi_dsi"
    "gpu_sched"
    "panel_edp"
    "panel_simple"
    "panfrost"
    "pwm_bl"

    # USB / Type-C related modules
    "fusb302"
    "tcpm"
    "typec"

    # Misc. modules
    "cw2015_battery"
    "gpio_charger"
    "rtc_rk808"
  ];

  networking.hostName = "jaal";

}
