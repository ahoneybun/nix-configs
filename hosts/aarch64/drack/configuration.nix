{ config, lib, pkgs, ... }:

{
  imports = [
    (import <mobile-nixos/lib/configuration.nix> { device = "oneplus-fajita"; })
    ./hardware-configuration.nix
    <mobile-nixos/examples/phosh/phosh.nix>
  ];

  # Kernel changes
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # NetworkManager
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  networking.hostName = "peebee";
  
  # SSH
  services.openssh = {
    enable = true;
    };

  # Use PulseAudio
  hardware.pulseaudio.enable = true;
  
  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  
  # Bluetooth audio
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  
  # Enable power management options
  powerManagement.enable = true;
  
  # It's recommended to keep enabled on these constrained devices
  zramSwap.enable = true;

  # Auto-login for phosh
  services.xserver.desktopManager.phosh = {
    user = "aaronh";
  };

  time.timeZone = "America/Denver";
  
  users.users."aaronh" = {
    isNormalUser = true;
    description = "Aaron Honeycutt";
    hashedPassword = "$6$zOZeSMch129yV5i1$9E0sFdMo4qIBUZgPKgl5AXKlYNku12gv2owPy7FSpC2W4qMofTzoX2KFLmGxERdI8A7n0kyJElcUFQGIS940j1";
    extraGroups = [
      "dialout"
      "feedbackd"
      "networkmanager"
      "video"
      "wheel"
    ];

  # GUI
  packages = with pkgs; [
    portfolio-filemanager

  # CLI
    grim
    ];
  }; 

  # Remove GNOME packages
  environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
  ]);

  environment.systemPackages = (with pkgs; [
  # rest of your packages
  ]);

  system.stateVersion = "23.11";
