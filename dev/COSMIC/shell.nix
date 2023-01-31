{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ 
       buildPackages.cargo
       buildPackages.just
       buildPackages.gnumake
       buildPackages.meson
       buildPackages.gcc
       ];
}
