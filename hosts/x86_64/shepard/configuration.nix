{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "shepard"; 

    hardware.opengl = {
        extraPackages = with pkgs; [ libvdpau-va-gl ];
        driSupport32Bit = true;
    };

    # Allow Unfree
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = 
        with pkgs; 
        [
           steam
        ]; 
}
