# WIP might not work yet

{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ 
       appstream-glib
       cargo
       cmake
       dbus
       desktop-file-utils
       egl-wayland
       glib
       gtk4
       just
       llvm
       libclang
       libglvnd
       libinput
       libpulseaudio
       libxkbcommon
       mesa
       meson
       ninja
       pkg-config
       seatd
       systemd
       ];
}
