{
  description = "COSMIC Development Environment";

  inputs = {
    nixpkgs = {url = "github:NixOS/nixpkgs/nixpkgs-unstable";};
    flake-utils = {url = "github:numtide/flake-utils";};
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      inherit (nixpkgs.lib) optional;
      pkgs = import nixpkgs {inherit system;};
      fhs = pkgs.buildFHSUserEnv {
        name = "COSMIC";
        targetPkgs = pkgs: (with pkgs; [
          # There is a lot here, because I am not sure about your system. :)
          xorg.libX11 
          xorg.libXext 
          xorg.libxcb 
          udev
        #runScript = "bash -c ./pico8";
      };
    in {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          fhs
        ];
        shellHook = ''
          if [ -e pico8 ]
          then
              tput setaf 2; echo "Pico-8 binary present. Type 'pico8' to get started."; tput sgr0;
          else
              tput setaf 3; echo "No Pico-8 binary present. Please download it."; tput sgr0;
              echo "You can purchase it here:"
              tput setaf 2; echo "https://www.lexaloffle.com/pico-8.php"; tput sgr0;
          fi
        '';
      };
    });
}
