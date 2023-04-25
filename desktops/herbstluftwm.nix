{ config, pkgs, ... }: 

{
  # Start herbstluftwm
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    windowManager.herbstluftwm.enable = true;
  };

  environment.systemPackages = (with pkgs; [
    polybar # status bar
    rofi # launcher
  ]);
}



