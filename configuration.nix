{ config, pkgs, ... }: 

{
   # Import other configuration modules
   # (hardware-configuration.nix is autogenerated upon installation)
   # paths in nix expressions are always relative the file which defines them
   imports =
       [
           ./hardware-configuration.nix
           ./programs.nix
       ];

   # Latest kernel
   boot.kernelPackages = pkgs.linuxPackages_latest;

   boot.loader = {
      systemd-boot.enable = true;
   };

   boot.initrd.luks.devices = {
      crypt-root = {
         device = "/dev/disk/by-label/luks";
         preLVM = true;
      };
   };

   # Name your host machine
   # networking.hostName = "NixOS"; 
   networking.networkmanager.enable = true;

   # Set your time zone.
   time.timeZone = "America/Denver";

   # Enter keyboard layout
   services.xserver.layout = "us";

   # Enable Flatpak
   xdg = {
      portal = {
         enable = true;
         extraPortals = with pkgs; [
            xdg-desktop-portal-wlr
            xdg-desktop-portal-kde
         ];
       };
   };

   services.flatpak.enable = true;

   # Enable fwupd
   services.fwupd.enable = true;

   # Define user accounts
   users.extraUsers.aaronh = {
           description = "Aaron Honeycutt";
           home = "/home/aaronh";
           extraGroups = [ "wheel" "networkmanager" "adm"];
           isNormalUser = true;
           hashedPassword = "$6$aAcbLtqiqzySifls$jdKMOQjoWITHD/dWNNZVUH/qNc6aoJ7v4zYofi0U7IJSVTbmOfChS3mzaJbp57AodjdPNKPrnrip8Nlh2Qanx.";
   };
    
   # Allow Unfree
   nixpkgs.config.allowUnfree = true;

   # Enable 32 Bit libraries for applications like Steam
   hardware.opengl.driSupport32Bit = true;

   # Install some packages
   environment.systemPackages = 
           with pkgs; 
           [
               firefox
               fish
               flatpak
               git
               steam
               thunderbird
               restic
               wget
           ]; 
 
   # Enable the OpenSSH daemon
   services.openssh.enable = true;

   # Turn off PulseAudio
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

   # Enable CUPS
   services.printing.enable = true;

   # System 
   system.stateVersion = "22.11";
   system.autoUpgrade.enable = true;
   system.autoUpgrade.allowReboot = true;

}
