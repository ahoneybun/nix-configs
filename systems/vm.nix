{ config, pkgs, ... }: 

{
   imports =
       [
#           ./hardware-configuration.nix
       ];

   # Latest kernel
   boot.kernelPackages = pkgs.linuxPackages_latest;
   # Add kernel parameters for virtual machines
   boot.kernelParams = [ "vfio-pci.ids=8086:9b41" "qxl" "bochs_drm"];

   boot.loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "0";
   };

   #nix.settings.auto-optimise-store = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];

   nix.gc = {
     automatic = true;
     dates = "weekly";
     options = "--delete-older-than 30d";
   };

   networking = {
      networkmanager.enable = true;
      hostName = "vm";
   };

   # Set your time zone.
   time.timeZone = "America/Denver";

   # Enter keyboard layout
   services.xserver.layout = "us";

   # Define user accounts
   users.users.aaronh = {
           description = "Aaron Honeycutt";
           home = "/home/aaronh";
           extraGroups = [ "wheel" "networkmanager" "adm"];
           isNormalUser = true;
           hashedPassword = "$6$aAcbLtqiqzySifls$jdKMOQjoWITHD/dWNNZVUH/qNc6aoJ7v4zYofi0U7IJSVTbmOfChS3mzaJbp57AodjdPNKPrnrip8Nlh2Qanx.";

      packages = with pkgs; [
         neofetch
      ];
   };
    
   # Allow Unfree
   nixpkgs.config.allowUnfree = true;

   # Install some packages
   environment.systemPackages = 
           with pkgs; 
           [
               cargo
               dmidecode
               git
               git-lfs         
               lshw
               nix-index
               nvd
               unzip
               wget
               xz
            ]; 
 
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

   # Enable services
   services.fwupd.enable = true;
   services.openssh.enable = true;

   system.activationScripts.diff = {
     supportsDryActivation = true;
     text = ''
       ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
     '';
   };

   # System 
   system.stateVersion = "23.11";
   system.autoUpgrade.enable = true;
}
