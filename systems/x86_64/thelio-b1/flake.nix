{
  description = "Joker";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      "joker" = nixpkgs.lib.nixosSystem {
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
                device = "/dev/sda";
                preLVM = true;
                };
              };
              
              # kernelPackages = pkgs.linuxPackages_latest;
              # kernelParams = [ "console=ttyS0,1920n8" ];

              binfmt.emulatedSystems = [ "aarch64-linux" ];

              loader.systemd-boot.enable = true;
              loader.systemd-boot.consoleMode = "0";
            };
             
            networking = {
              hostName = "joker";
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

                firefox
              ];
            };

            environment.systemPackages = with pkgs; [
              avahi
              dmidecode
              libcamera
              lshw
              nix-index
              sysstat
              tree
              unzip
              wget
            ];

            # GNOME
            services.xserver = {
              enable = true;
              displayManager.gdm.enable = true;
              desktopManager.gnome.enable = true;
            };

            # Add GNOME packages
            environment.systemPackages = (with pkgs; [
              gnome.dconf-editor
              gnome.gnome-tweaks
              gnomeExtensions.appindicator
              gnomeExtensions.pop-shell
              gnomeExtensions.pop-launcher-super-key
            ]);

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
              stateVersion = "23.05";
              autoUpgrade.enable = true;
            };
          })
        ];
      };
    };
  };
}
