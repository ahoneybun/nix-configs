{ config, pkgs, lib, ... }:

{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "cast"
      "esphome"
      "google_translate"
      "lacrosse"
      "lacrosse_view"
      "met"
      "nest"
      "radio_browser"
      "systemmonitor"
      "tplink"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
      homeassistant = {
         unit_system = "imperial";
         temperature_unit = "F";
         time_zone = "America/Denver";
      };
      feedreader.urls = [ "https://nixos.org/blogs.xml" ];
    };
  };
}
