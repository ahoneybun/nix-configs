{ config, pkgs, ... }: 

{
  # Desktop
  services.xserver = {
    enable = true;
    displayManager.lightdm.greeters.pantheon.enable = false;
    displayManager.lightdm.enable = false;
    desktopManager.pantheon.enable = true;
  };

  # Wingpangel and Switchboard plugins
  wingpanel-with-indicators.override {
    indicators = [
      pkgs.some-special-indicator
    ];
  };

  switchboard-with-plugs.override {
    plugs = [
      pkgs.some-special-plug
    ];
  };
  
  # Remove Pantheon packages
  environment.pantheon.excludePackagess = (with pkgs; [
  pantheon.appcenter # AppCenter as it can't be used on NixOS
  ]);

  # Hacks
  systemd.extraConfig = ''
  DefaultTimeoutStopSec=10s
  DefaultTimeoutStartSec=10s
  '';
}
