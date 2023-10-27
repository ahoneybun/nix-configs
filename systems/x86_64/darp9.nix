{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "darp9"; 

    # System76
    hardware.system76.enableAll = true;
}
