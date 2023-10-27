{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "lemp12"; 

    # System76
    hardware.system76.enableAll = true;
}
