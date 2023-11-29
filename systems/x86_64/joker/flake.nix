{
  description = "Joker";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      "thelio-b1" = nixpkgs.lib.nixosSystem {
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

            nixpkgs.config.allowUnfree = true; 

            boot = {
              initrd.luks.devices = {
                root = { 
                device = "/dev/nvme0n1p2";
                preLVM = true;
                };
              };
              
              # kernelPackages = pkgs.linuxPackages_latest;
              # kernelParams = [ "console=ttyS0,1920n8" ];

              loader.systemd-boot.enable = true;
              loader.systemd-boot.consoleMode = "0";
            };
             
            networking = {
              hostName = "thelio-b1";
              networkmanager.enable = true;
            };

            users.users.aaronh = {
              isNormalUser = true;
              extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
              packages = with pkgs; [
                cargo
                git
                git-lfs
                mdbook
                neofetch
                restic
                roboto-slab
              ];
            };

            environment.systemPackages = with pkgs; [
              avahi
              cosmic-edit
              dmidecode
              firefox
              libcamera
              lshw
              nix-index
              sysstat
              tree
              unzip
              wget
  
              gnome.dconf-editor
            ];

            # GNOME
            services.xserver = {
              enable = true;
              displayManager.gdm.enable = true;
              desktopManager.gnome.enable = true;
            };

            # Remove GNOME packages
            environment.gnome.excludePackages = (with pkgs; [
              epiphany # web browser
              gnome.geary
              gnome.gnome-software
              gnome-connections
              gnome-photos
              gnome-tour
            ]);

            # Services
            services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

            hardware.pulseaudio.enable = false;
             
            security.rtkit.enable = true;
            services.pipewire = {
              enable = true;
              alsa.enable = true;
              alsa.support32Bit = true;
              pulse.enable = true;
            };

            services = {
              fwupd.enable = true;
              printing.enable = true;
              openssh.enable = true;
            };
 
            services.avahi = {
              enable = true;
              nssmdns = true;
              openFirewall = true;
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
