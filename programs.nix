{ config, pkgs, ... }: 

{
   # virt-manager
   virtualisation.libvirtd.enable = true;

   # Packages
   environment.systemPackages = 
           with pkgs; 
              [
               # Comms
               discord

               # Office
               libreoffice-fresh
               slack

               # Work
               virt-manager
               vscode

               # Streaming
               obs-studio
              ];

   programs.fish.enable = true;

}
