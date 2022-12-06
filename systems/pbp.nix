{ config, pkgs, lib, ... }:

{
  imports =
    [
#       ./programs.nix
    ];

  boot.loader = {
    efi = {
    canTouchEfiVariables = false;
  };

  grub = {
     enable = true;
     efiSupport = true;
     version = 2;
     device = "nodev";
    };
  };

  boot.initrd.luks.devices = {
    crypt-root = {
      device = "/dev/disk/by-label/luks";
      preLVM = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "btrfs";
      options = [ "noatime" ];
    };
  };

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
