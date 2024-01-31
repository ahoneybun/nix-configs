{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "shepard"; 

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
