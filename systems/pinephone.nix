{ config, lib, pkgs, ... }:

{
  imports = [
    (import <mobile-nixos/lib/configuration.nix> { device = "pine64-pinephone"; })
    ./hardware-configuration.nix
    <mobile-nixos/examples/phosh/phosh.nix>
  ];

  networking.hostName = "mobile-nixos";

  #
  # Opinionated defaults
  #
  
  # Use Network Manager
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  
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

  #
  # User configuration
  #
  
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
    deja-dup
    foliate
    headlines
    gnome.gnome-clocks
    gnome.gnome-calculator
    gnome-feeds
    gnome-photos
    gnome-podcasts
    lollypop
    marker
    portfolio-filemanager
    spot
    tootle

  # CLI
    grim

  ];
};

  time.timeZone = "America/Denver";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
