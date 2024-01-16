{
   description = "Generic System Flake file";

   inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
         disko = {
            url = github:nix-community/disko;
            inputs.nixpkgs.follows = "nixpkgs";
         };
   };

   outputs = { self, nixpkgs, disko, ... }@inputs: {
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
               #./configuration.nix
               ./hardware-configuration.nix
            ];
         };

         "dev-one" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
               # Add Disko for disk management
               disko.nixosModules.disko
               ./disko-config.nix
               ./configuration.nix
               ./hardware-configuration.nix
            ];
         };

         "vm" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
               # Add Disko for disk management
               disko.nixosModules.disko
               ./disko-config.nix
               ./hardware-configuration.nix
            ];
         };
         
      };
   };
}
