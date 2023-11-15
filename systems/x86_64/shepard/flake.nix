{
  description = "Shepard";

  inputs = {
#    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs-unstable, nixos-hardware, ... }@inputs: {
    nixosConfigurations = {
      "shepard" = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Import the configuration.nix we used before, so that the old configuration file can still take effect. 
          # Note: /etc/nixos/configuration.nix itself is also a Nix Module, so you can import it directly here
#          nixos-hardware.nixosModules.raspberry-pi-4	
#          ./configuration.nix
          ./hardware-configuration.nix
          ./gnome.nix

        ({config, pkgs, ...}: {

          # Latest kernel
          boot.kernelPackages = pkgs.linuxPackages_latest;
  
          boot.loader = {
             systemd-boot.enable = true;
             systemd-boot.consoleMode = "0";
          }; 

          boot.initrd.luks.devices = {
             root = {
                device = "/dev/nvme1n1p2";
                preLVM = true; 
             };
          };

          nix = {
             settings.auto-optimise-store = true;
             settings.experimental-features = [ "nix-command" "flakes" ];
 
             gc = {
                automatic = true;
                dates = "weekly";
                options = "--delete-older-than 30d";
             };
          };

          networking = {
             hostName = "shepard";
             networkmanager.enable = true;   
          };

          time.timeZone = "America/Denver";

          # Stable
          environment.systemPackages = with pkgs; [
             avahi
             cargo
             cosmic-edit
             dmidecode
             fire
             firefox
             fish
             git
             git-lfs
             libcamera
             lshw
             roboto-slab
             neofetch
             restic
             unzip
             wget
             xz
          ];

          users.users.aaronh = {
             description = "Aaron Honeycutt";
             home = "/home/aaronh";
             extraGroups = [ "wheel" "networkmanager" "adm" ];
             isNormalUser = true;
             shell = pkgs.fish;
             hashedPassword = "$6$aAcbLtqiqzySifls$jdKMOQjoWITHD/dWNNZVUH/qNc6aoJ7v4zYofi0U7IJSVTbmOfChS3mzaJbp57AodjdPNKPrnrip8Nlh2Qanx.";

             packages = with pkgs; [
                signal-desktop
                youtube-music
             ];
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

          # Allow Unfree
          nixpkgs.config.allowUnfree = true;

          # System
          system = {
             stateVersion = "23.11";
             autoUpgrade.enable = true;
          };  
         })
       ];
     };
   };
 };
}
