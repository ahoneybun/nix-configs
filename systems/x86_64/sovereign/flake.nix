{
  description = "Sovereign";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      "sovereign" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Import the configuration.nix we used before, so that the old configuration file can still take effect. 
          # Note: /etc/nixos/configuration.nix itself is also a Nix Module, so you can import it directly here
#          ./configuration.nix
          ./hardware-configuration.nix
          ./stoners-space.nix

          ({config, pkgs, ...}: {
             nix = {
                settings.auto-optimise-store = true;
                settings.experimental-features = [ "nix-command" "flakes" ];
                settings.extra-platforms = [ "aarch64-linux" ];
           
                gc = {
                   automatic = true;
                   dates = "weekly";
                   options = "--delete-older-than 30d";
                };

                buildMachines = [{
                   hostName = "localhost";
                   systems = [ "x86_64-linux"
                               "aarch64-linux"
                               "x86_64-darwin"
                               "aarch64-darwin" ];
                   supportedFeatures = [ "kvm" "nixos-test" "big-parallel" "benchmark" ];
                   maxJobs = 8;
                }];

             };

             boot = {
                kernelPackages = pkgs.linuxPackages_latest;
                kernelParams = [ "console=ttyS0,1920n8" ];

                binfmt.emulatedSystems = [ "aarch64-linux" ];

                loader.grub.enable = true;
                loader.grub.extraConfig = ''
                   serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
                   terminal_input serial;
                   terminal_output serial
                   '';
                loader.grub.device = "nodev"; # or "nodev" for efi only
                loader.timeout = 10;
             };
             
             networking = {
                hostName = "sovereign";

                firewall = {
                   enable = true;
                   allowedTCPPorts = [ 80 443 ];
                };
                
                usePredictableInterfaceNames = false;
                useDHCP = false;
                interfaces.eth0.useDHCP = true;

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
                acme-sh
                git
                git-lfs
                mtr
                neofetch
                sysstat
                tree
                wget
             ];

             security.acme.acceptTerms = true;
             security.acme.defaults.email = "aaronhoneycutt@proton.me";
        
             services.openssh = {
                enable = true;
                settings.PermitRootLogin = "no";
             };

             system = {
                stateVersion = "23.05";
                autoUpgrade.enable = true;
             };
          })
        ];
      };
    };
  };
}
