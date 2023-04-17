{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "hp-omen"; 

    # NVIDIA
    services.xserver.videoDrivers = [ "nvidia" ];   
    hardware.opengl.enable = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    ## Enable 32 Bit libraries for applications like Steam
    hardware.opengl.driSupport32Bit = true;

    # Allow Unfree
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = 
        with pkgs; 
        [
           steam
        ]; 

}
