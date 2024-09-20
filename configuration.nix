{ config, pkgs, inputs, ... }: 

{
   imports =
       [
            ./hardware-configuration.nix
       ];

   # Latest kernel
#   boot.kernelPackages = pkgs.linuxPackages_latest;

   boot.loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "0";
      systemd-boot.configurationLimit = 5;
   };

   boot.plymouth.enable = true;
   boot.initrd.systemd.enable = true;
   boot.kernelParams = [ "quiet" ];

   #nix.settings.auto-optimise-store = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];

   nix.gc = {
     automatic = true;
     dates = "weekly";
     options = "--delete-older-than 1w";
   };

   swapDevices = [ {
     device = "/var/lib/swapfile";
     size = 16*1024;
   } ];

   zramSwap.enable = true;

   networking.networkmanager.enable = true;

   # Set your time zone.
   time.timeZone = "America/Denver";

   # Enter keyboard layout
   services.xserver.xkb.layout = "us";

   # Define user accounts
   users.users.aaronh = {
           description = "Aaron Honeycutt";
           home = "/home/aaronh";
           extraGroups = [ "wheel" "networkmanager" "adm"];
           isNormalUser = true;
           hashedPassword = "$6$aAcbLtqiqzySifls$jdKMOQjoWITHD/dWNNZVUH/qNc6aoJ7v4zYofi0U7IJSVTbmOfChS3mzaJbp57AodjdPNKPrnrip8Nlh2Qanx.";

   };
    
   # Allow Unfree
   nixpkgs.config.allowUnfree = true;

   # Install some packages
   environment.systemPackages = 
           with pkgs; 
           [
               avahi
               dmidecode
               fira
               firefox
               git
               git-lfs         
               helix
               libcamera
               lshw
               restic
               roboto-slab
               syncthing
               nvd
               unzip
               wget
               xz
               zlib

              # Packages from Flake Inputs
              inputs.nix-software-center.packages.${system}.nix-software-center
            ]; 

   programs.nix-ld.enable = true;
   programs.nix-ld.libraries = with pkgs; [
     # Add any missing dynamic libraries for unpackaged programs
     # here, NOT in environment.systemPackages
   ];

   # Enable COSMIC
   services.desktopManager.cosmic.enable = true;
   services.displayManager.cosmic-greeter.enable = true;
 
   # Enable/Disable hardware
   ## Turn off PulseAudio
   hardware.pulseaudio.enable = false;

   # Enable Pipewire
   security.rtkit.enable = true;
   services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
   };

   # Enable Bluetooth
   hardware.bluetooth.enable = true;

   # Enable services
   services.fwupd.enable = true;
   services.printing.enable = true;
   services.openssh.enable = true;

   services.avahi = {
      enable = true;
      #nssmdns4 = true;
      openFirewall = true;
         # Needed for detecting scanners
         publish = {
            enable = true;
            addresses = true;
            userServices = true;
         };
   };

   # Scanner support
   hardware.sane.enable = true;
   hardware.sane.extraBackends = [ pkgs.sane-airscan ];
   services.ipp-usb.enable = true;

   services.hardware.bolt.enable = true;

   system.activationScripts.diff = {
     supportsDryActivation = true;
     text = ''
       ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
     '';
   };

   # System 
   system.stateVersion = "24.05";
   system.autoUpgrade.enable = true;
}
