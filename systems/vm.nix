{ config, pkgs, ... }: 

{
   # Add kernel parameters for virtual machines
   boot.kernelParams = [ "vfio-pci.ids=8086:9b41" "qxl" "bochs_drm"];

   # Name your host machine
   networking.hostName = "vm"; 
}
