{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "galp4"; 

    # System76
    hardware.system76.enableAll = true;
}
