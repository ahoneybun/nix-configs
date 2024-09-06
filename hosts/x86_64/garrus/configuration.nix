{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "garrus"; 

    # System76
    hardware.system76.enableAll = true;
    environment.systemPackages = with pkgs; [
        system76-keyboard-configurator
    ];

}
