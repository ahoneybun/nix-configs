{ config, pkgs, ... }: 

{
   # Import other configuration modules
   # (hardware-configuration.nix is autogenerated upon installation)
   # paths in nix expressions are always relative the file which defines them
   imports =
       [
           ./hardware-configuration.nix
#           ./programs.nix
       ];

   # Latest kernel
   # boot.kernelPackages = pkgs.linuxPackages_latest;

   boot.loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "0";
   };

   boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

   nix.settings.extra-platforms = [ "aarch64-linux" ];
   nix.settings.auto-optimise-store = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];

   nix.gc = {
     automatic = true;
     dates = "weekly";
     options = "--delete-older-than 30d";
   };

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

   # Define user accounts
   users.users.aaronh = {
           description = "Aaron Honeycutt";
           home = "/home/aaronh";
           extraGroups = [ "wheel" "networkmanager" "adm"];
           isNormalUser = true;
           hashedPassword = "$6$aAcbLtqiqzySifls$jdKMOQjoWITHD/dWNNZVUH/qNc6aoJ7v4zYofi0U7IJSVTbmOfChS3mzaJbp57AodjdPNKPrnrip8Nlh2Qanx.";

      packages = with pkgs; [
        # Fonts
         fira
         fira-mono
         mdbook
         restic
         roboto-slab
         
        # CLI
         neofetch
      ];
   };
    
   # Allow Unfree
   nixpkgs.config.allowUnfree = true;

   # Install some packages
   environment.systemPackages = 
           with pkgs; 
           [
               avahi
               cargo
               dmidecode
               libcamera
               lshw
               nix-index
               toybox
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

   # Enable Bluetooth
   hardware.bluetooth.enable = true;

   # Enable services
   services.flatpak.enable = true;
   services.fwupd.enable = true;
   services.printing.enable = true;
   services.openssh.enable = true;

   services.avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
   };

   # System 
   system.stateVersion = "22.11";
   system.autoUpgrade.enable = true;

}
