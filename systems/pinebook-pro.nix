{ config, pkgs, lib, ... }:

{
  imports =
    [
#       "${nixos-hardware}/pine64/pinebook-pro"
#        <nixos-hardware/pine64/pinebook-pro>
        ./hardware-configuration.nix
#       ./programs.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  networking = {
    hostName = "pbp";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Denver";

  environment.systemPackages = 
            with pkgs; 
            [
                fish
                git
                neofetch
                restic
                wget
            ]; 

  # Define user accounts
    users.extraUsers.aaronh = {
            description = "Aaron Honeycutt";
            home = "/home/aaronh";
            extraGroups = [ "wheel" "networkmanager" "adm"];
            isNormalUser = true;
            hashedPassword = "$6$aAcbLtqiqzySifls$jdKMOQjoWITHD/dWNNZVUH/qNc6aoJ7v4zYofi0U7IJSVTbmOfChS3mzaJbp57AodjdPNKPrnrip8Nlh2Qanx.";
    };

  # Enable Pipewire
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
 
  # Turn off PulseAudio
  hardware.pulseaudio.enable = false;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Enable CUPS
  services.printing.enable = true;

  # Enable GPU acceleration
  # hardware.raspberry-pi."4".fkms-3d.enable = true;

  # Allow Unfree
  nixpkgs.config.allowUnfree = true;

  # GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # System 
  system.stateVersion = "22.11";
  system.autoUpgrade.enable = true;


}
