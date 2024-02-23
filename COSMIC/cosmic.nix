{ unstable, config, pkgs, ... }:

{
  # Enable COSMIC
  services.xserver = {
     enable = true;
     displayManager.cosmic-greeter.enable = true;
     desktopManager.cosmic.enable = true;
  };

  # Grab unstable NixOS packages for using and building COSMIC
  environment.systemPackages = (with pkgs; [
     rustc
     cargo
     cosmic-launcher
     cosmic-applibrary
     cosmic-panel
     cosmic-greeter
     cosmic-settings
     cosmic-settings-daemon
     cosmic-screenshot
     cosmic-term
     cosmic-files
     cosmic-edit
     xdg-desktop-portal-cosmic
     # For screenshots until cosmic-screenshot is updated
     ksnip
  ]);

  # Fix cosmic-greeter
  security.pam.services.cosmic-greeter = {};
}
