{ config, pkgs, ... }: 

{
    boot.kernelModules = [ "wl" ];
    boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
    boot.blacklistedKernelModules = [ "b43" "bcma" ];

    # Name your host machine
    networking.hostName = "macbook"; 
}
