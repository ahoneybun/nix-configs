{
  description = "Generic System Flake file";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Import the configuration.nix we used before, so that the old configuration file can still take effect. 
          # Note: /etc/nixos/configuration.nix itself is also a Nix Module, so you can import it directly here
#          ./configuration.nix
          ./hardware-configuration.nix

          ({config, pkgs, ...}: {
             nix = {
                settings.auto-optimise-store = true;
                settings.experimental-features = [ "nix-command" "flakes" ];
           
                gc = {
                   automatic = true;
                   dates = "weekly";
                   options = "--delete-older-than 30d";
                };

             };

             boot = {
                kernelPackages = pkgs.linuxPackages_latest;

                loader = {
                   systemd-boot.enable = true;
                   systemd-boot.consoleMode = "0";
                };

             };
             
             networking = {
                hostName = "nixos";

             };

             users.users.aaronh = {
                isNormalUser = true;
                extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
                hashedPassword = "$6$aAcbLtqiqzySifls$jdKMOQjoWITHD/dWNNZVUH/qNc6aoJ7v4zYofi0U7IJSVTbmOfChS3mzaJbp57AodjdPNKPrnrip8Nlh2Qanx.";
                packages = with pkgs; [
                   cargo
                   git
                   git-lfs
                ];
             };

             environment.systemPackages = with pkgs; [
                git
                git-lfs
                neofetch
                tree
                wget
             ];
        
             services.openssh = {
                enable = true;
                settings.PermitRootLogin = "no";
             };

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
