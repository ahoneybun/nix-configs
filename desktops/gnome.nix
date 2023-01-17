{ config, pkgs, ... }: 

{
  # GNOME
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Add GNOME packages
  environment.systemPackages = [
    pkgs.amberol
  ];
  
  # Remove GNOME packages
  environment.gnome.excludePackages = (with pkgs; [
  epiphany # web browser
  gnome-connections
  gnome-photos
  gnome-tour
  ]);

  # Services
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

}
