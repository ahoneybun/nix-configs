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
   };
}
