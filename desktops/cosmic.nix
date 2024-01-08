{ config, pkgs, ... }: 

{
  # GNOME
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.cosmic.enable = true;
  };

}
