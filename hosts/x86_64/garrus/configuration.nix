{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "garrus"; 

    # System76
    hardware.system76.enableAll = true;
    environment.systemPackages = with pkgs; [
        system76-keyboard-configurator
        firmware-manager
    ];

    # NVIDIA
#    services.xserver.videoDrivers = [ "nvidia" ];   
#    hardware.opengl.enable = true;
#    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Allow Unfree
    nixpkgs.config.allowUnfree = true;
}
