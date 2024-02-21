{ config, pkgs, ... }: 

{

   # virt-manager
   virtualisation.libvirtd.enable = true;

   # Packages
   environment.systemPackages = with pkgs; [
      # Comms
      slack

      # Web
      google-chrome

      # VM
      quickemu
      spice
      spice-gtk
      virt-manager
   ];
}
