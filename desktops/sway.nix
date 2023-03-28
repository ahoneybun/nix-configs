{ config, pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    alacritty # gpu accelerated terminal
    sway
    wayland
    xdg-utils # for openning default programms when clicking links
    glib # gsettings
    gnome3.adwaita-icon-theme  # default gnome cursors
    swaylock
    swayidle
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    bemenu # wayland clone of dmenu
    mako # notification system developed by swaywm maintainer
    wdisplays # A graphical application for configuring displays in Wayland compositors
  ];

    services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
