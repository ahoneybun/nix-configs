{ config, pkgs, ... }: 

{
   # Packages
   environment.systemPackages = with pkgs; [
     cargo
     pkg-config
     libxkbcommon
     rustc
     wayland
   ];
}
