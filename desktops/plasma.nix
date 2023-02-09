{ config, pkgs, ... }: 

{
    # Plasma
    services.xserver = {
       enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.settings.Wayland.SessionDir =
       "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
    desktopManager.plasma5.enable = true;
    };

    # Install some packages
    environment.systemPackages = 
            with pkgs; 
            [
               libsForQt5.ark
               libsForQt5.bismuth
               libsForQt5.kalendar
               libsForQt5.kate
               libsForQt5.kdeconnect-kde
               libsForQt5.kde-gtk-config
               libsForQt5.neochat
               libsForQt5.plasma-framework
               libsForQt5.plasma-nm
               libsForQt5.plasma-pa
               libsForQt5.sddm
            ];
}
