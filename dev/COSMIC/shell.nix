{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ 
       cargo
       glib
       just
       libxkbcommon
       meson
       pkg-config
       ];
}
