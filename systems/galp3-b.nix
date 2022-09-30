{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "galp3-b"; 

    # System76
    hardware.system76.enableAll = true;
}
