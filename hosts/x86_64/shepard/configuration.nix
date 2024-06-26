{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "shepard"; 

    # Enable binfmt emulation of aarch64-linux.
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    # Allow Unfree
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = 
        with pkgs; 
        [
           steam
        ]; 
}
