{ config, pkgs, lib, ... }:

{
  imports = [
#         <nixos-hardware/raspberry-pi/4>
         ./home-assistant.nix
#        ./gnome.nix
#        ./programs.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];

    loader = {

      grub.enable = false;

      generic-extlinux-compatible.enable = true;

    };
  };

# boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = "vetra";
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
    users.users.aaronh = {
            description = "Aaron Honeycutt";
            home = "/home/aaronh";
            extraGroups = [ "wheel" "networkmanager" "adm"];
            isNormalUser = true;
            shell = pkgs.fish;
            hashedPassword = "$6$aAcbLtqiqzySifls$jdKMOQjoWITHD/dWNNZVUH/qNc6aoJ7v4zYofi0U7IJSVTbmOfChS3mzaJbp57AodjdPNKPrnrip8Nlh2Qanx.";
    };

  programs.fish.enable = true;

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

  # Enable SSH
  services.openssh.enable = true;

  # Enable CUPS
  services.printing.enable = true;

  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;

  # Allow Unfree
  nixpkgs.config.allowUnfree = true;

  services.hydra = {
    enable = false;
    hydraURL = "http://localhost:3000";
    notificationSender = "hydra@localhost";
    buildMachinesFiles = [];
    useSubstitutes = true;
  };
  
  # System 
  system.stateVersion = "24.05";
  system.autoUpgrade.enable = true;
}
