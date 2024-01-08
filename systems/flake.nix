{
  description = "VM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    disko = {
       url = github:nix-community/disko;
       inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ... }@inputs: {
    nixosConfigurations = {
      "vm" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Import the configuration.nix we used before, so that the old configuration file can still take effect. 
          # Note: /etc/nixos/configuration.nix itself is also a Nix Module, so you can import it directly here
#          ./configuration.nix
           disko.nixosModules.disko
           ./disko-config.nix
           {
              _module.args.disks = [ "/dev/vda" ];
           }
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
               hostName = "vm";
               networkmanager.enable = true;
             };

             users.users.aaronh = {
                isNormalUser = true;
                extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
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

