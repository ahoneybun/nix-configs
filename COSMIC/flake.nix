{
   description = "Generic System Flake file";

   inputs = {
      nixpkgs.url = "github:lilyinstarlight/nixpkgs/tmp/cosmic";
      unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
      disko = {
         url = github:nix-community/disko;
         inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
         url = "github:nix-community/home-manager/master";
         inputs.nixpkgs.follows = "nixpkgs";
      };
      pinix.url = "github:remi-dupre/pinix";
   };

   outputs = { self, nixpkgs, unstable, disko, home-manager, pinix, ... }@inputs: {
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
         
         "garrus" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit unstable; };
            modules = [
               # Add Disko for disk management
               disko.nixosModules.disko
               ./disko-config.nix
               ./cosmic.nix
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
