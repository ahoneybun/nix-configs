{ config, pkgs, ... }: 

{
    # Plasma
    services.xserver = {
       enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
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
