{ config, pkgs, ... }: 

{
    # Plasma
    services.xserver = {
       enable = true;

    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    };

    # Install some packages
    environment.systemPackages = 
            with pkgs; 
            [
               kdePackages.dragon
               kdePackages.merkuro
               kdePackages.neochat
            ];
}
