{
  description = "Vetra";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: {
    nixosConfigurations = {
      "vetra" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          # Import the configuration.nix we used before, so that the old configuration file can still take effect. 
          # Note: /etc/nixos/configuration.nix itself is also a Nix Module, so you can import it directly here
          nixos-hardware.nixosModules.raspberry-pi-4	
#          ./configuration.nix

        ({config, pkgs, ...}: {
          fileSystems = {
             "/" = {
                device = "/dev/disk/by-label/NIXOS_SD";
                fsType = "ext4";
                options = [ "noatime" ];
             };
 
             "/mnt/ExtraDrive" = {
                device = "/dev/disk/by-uuid/72315f9e-ceda-4152-8e8d-09590affba28";
                fsType = "ext4";
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
             hostName = "vetra";
             networkmanager.enable = true;   
          };

          time.timeZone = "America/Denver";

          environment.systemPackages = with pkgs; [
             fish
             git
             neofetch
             restic
             wget
          ];

          users.users.aaronh = {
             description = "Aaron Honeycutt";
             home = "/home/aaronh";
             extraGroups = [ "wheel" "networkmanager" "adm" ];
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

          # Enable GPU Acceleration
          hardware.raspberry-pi."4".fkms-3d.enable = true;

          # Allow Unfree
          nixpkgs.config.allowUnfree = true;

          # System
          system = {
             stateVersion = "22.11";
             autoUpgrade.enable = true;
          };  
         })
       ];
     };
   };
 };
}
