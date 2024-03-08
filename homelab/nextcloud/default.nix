{ config, pkgs, lib, ... }:

{
  environment.etc."nextcloud-admin-pass".text = "test123";
  services.nextcloud = {
    enable = true;
    https = true;
    package = pkgs.nextcloud28;
    hostName = "localhost";
    config = {
       adminpassFile = "/etc/nextcloud-admin-pass";
    };
    settings.trusted_domains = [ "10.0.0.10*" ];
  };
}