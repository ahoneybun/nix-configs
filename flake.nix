{
   description = "Generic System Flake file";

   inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
      disko = {
         url = github:nix-community/disko;
         inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
         url = "github:nix-community/home-manager/release-23.11";
         inputs.nixpkgs.follows = "nixpkgs"; # Use system packages list where available
      };
      nixos-hardware.url = "github:NixOS/nixos-hardware/master";
   };

   outputs = { self, nixpkgs, disko, home-manager, nixos-hardware, ... }@inputs: {
      nixosConfigurations = {
         "nixos" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
               # Add Disko for disk management
               disko.nixosModules.disko
               ./disko-config.nix
               ./configuration.nix
               ./hardware-configuration.nix
            ];
         };

         "dev-one" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
               # Add Disko for disk management
               disko.nixosModules.disko
               ./disko-config.nix
               ./gnome.nix
               ./configuration.nix
               ./hardware-configuration.nix
               home-manager.nixosModules.home-manager
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.aaronh = import ./home.nix;
               }
            ];
         };

         "omen" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
               # Add Disko for disk management
               disko.nixosModules.disko
               ./disko-config.nix
               ./gnome.nix
               ./hp-omen.nix
               ./configuration.nix
               ./hardware-configuration.nix
               home-manager.nixosModules.home-manager
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.aaronh = import ./home.nix;
               }
            ];
         };
         
         "garrus" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
               # Add Disko for disk management
               disko.nixosModules.disko
               ./disko-config.nix
               ./gnome.nix
               ./garrus.nix
               ./configuration.nix
               ./hardware-configuration.nix
               home-manager.nixosModules.home-manager
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.aaronh = import ./home.nix;
               }
            ];
         };
         
         "jaal" = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = [
               # Add Disko for disk management
               disko.nixosModules.disko
               ./disko-config.nix
               ./gnome.nix
               ./jaal.nix
               ./configuration.nix
               ./hardware-configuration.nix
               home-manager.nixosModules.home-manager
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.aaronh = import ./home.nix;
               }
               nixos-hardware.nixosModules.pine64-pinebook-pro
            ];
         };

         "thelio-b1" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
               # Add Disko for disk management
               disko.nixosModules.disko
               ./disko-config.nix
               ./gnome.nix
               ./thelio-nvidia.nix
               ./configuration.nix
               ./hardware-configuration.nix
               home-manager.nixosModules.home-manager
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.aaronh = import ./home.nix;
               }
            ];
         };

         "shepard" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
               # Add Disko for disk management
               disko.nixosModules.disko
               ./disko-config.nix
               ./gnome.nix
               ./shepard.nix
               ./configuration.nix
               ./hardware-configuration.nix
               home-manager.nixosModules.home-manager
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.aaronh = import ./home.nix;
               }
            ];
         };

         "vm" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
               # Add Disko for disk management
               disko.nixosModules.disko
               ./disko-config.nix
               ./vm.nix
               ./configuration.nix
               ./hardware-configuration.nix
               home-manager.nixosModules.home-manager
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.aaronh = import ./home.nix;
               }
            ];
         };
         
      };
   };
}
