{ config, pkgs, ... }: 

{
  # Start herbstluftvm
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    windowManager.herbstluftvm.enable = {
      enable =true;
      extraPackages = with pkgs; [
        polybar # status bar
        rofi # launcher
     ];
  }};

  environment.systemPackages = (with pkgs; [
    firefox
  ]);
}

