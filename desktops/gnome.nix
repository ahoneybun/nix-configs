{ config, pkgs, ... }: 

{
  # GNOME
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Add GNOME packages
  environment.systemPackages = (with pkgs; [
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.pop-shell
    gnomeExtensions.pop-launcher-super-key
  ]);

  # Remove GNOME packages
  environment.gnome.excludePackages = (with pkgs; [
    epiphany # web browser
    gnome.geary
    gnome.gnome-software
    gnome-connections
    gnome-photos
    gnome-tour
  ]);

  # Services
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

}
