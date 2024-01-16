{
  description = "Generic System Flake file";

  inputs = {
   nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
      disko = {
         url = github:nix-community/disko;
         inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
         url = github:nix-community/home-manager;
         inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { self, nixpkgs, disko, home-manager, ... }@inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
           # Add Disko for disk management
           disko.nixosModules.disko
           ./disko-config.nix
           {
              _module.args.disks = [ "/dev/vda" ];
           }
           # Add Home-manager
           home-manager.nixosModules.home-manager
           {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.aaronh = import ./home.nix;
           }
          ./hardware-configuration.nix
         ];
      };

      "dev-one" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
           # Add Disko for disk management
           disko.nixosModules.disko
           ./disko-config.nix
           {
              _module.args.disks = [ "/dev/vda" ];
           }
           # Add Home-manager
           home-manager.nixosModules.home-manager
           {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.aaronh = import ./home.nix;
           }
          ./hardware-configuration.nix
         ];
      };

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
               networkmanager.enable = true;
            };

            users.users.aaronh = {
               isNormalUser = true;
               extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
               hashedPassword = "$6$aAcbLtqiqzySifls$jdKMOQjoWITHD/dWNNZVUH/qNc6aoJ7v4zYofi0U7IJSVTbmOfChS3mzaJbp57AodjdPNKPrnrip8Nlh2Qanx.";
            };

            environment.systemPackages = with pkgs; [
               git
               git-lfs
               tree
               wget
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
