# Builds now

{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ 
       appstream-glib
       cargo
       clang
       cmake
       dbus
       desktop-file-utils
       egl-wayland
       glib
       gtk4
       just
       llvm
       llvmPackages_15.llvm
       libclang
       libglvnd
       libinput
       libpulseaudio
       libxkbcommon
       mesa
       meson
       ninja
       pipewire
       pkg-config
       seatd
       systemd
       ];

  LIBCLANG_PATH = "${pkgs.llvmPackages_15.libclang.lib}/lib";

  }
