{ config, pkgs, ... }: 

{
  # Start herbstluftvm
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    windowManager.herbstluftvm.enable = true;
  };

  environment.systemPackages = (with pkgs; [
    polybar # status bar
    rofi # launcher
  ]);
}



