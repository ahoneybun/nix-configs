{ config, pkgs, ... }: 

{
  # Desktop
  services.xserver = {
    enable = true;
    desktopManager.pantheon.enable = true;
  };
  
  # Remove Pantheon packages
  environment.pantheon.excludePackages = (with pkgs; [
  pantheon.appcenter # AppCenter as it can't be used on NixOS
  ]);

}
