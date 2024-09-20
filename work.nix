{ config, pkgs, ... }: 

{

   # virt-manager
   virtualisation.libvirtd.enable = true;

   # Packages
   environment.systemPackages = with pkgs; [
      # Comms
      slack
      tuba

      # Tools
      copyq

      # VM
      quickemu
      spice
      spice-gtk
      virt-manager
   ];
}
