{
  description = "Harbinger";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      "harbinger" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Import the configuration.nix we used before, so that the old configuration file can still take effect. 
          # Note: /etc/nixos/configuration.nix itself is also a Nix Module, so you can import it directly here
#          ./configuration.nix
          ./hardware-configuration.nix
          ./ahoneybun-net.nix
          ./tildecafe-com.nix
          ./rockymtnlug-org.nix

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
                kernelParams = [ "console=ttyS0,1920n8" ];

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
                hostName = "harbinger";

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
