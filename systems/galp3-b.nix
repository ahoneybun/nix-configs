{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "Garrus"; 

    # System76
    hardware.system76.enableAll = true;
}
