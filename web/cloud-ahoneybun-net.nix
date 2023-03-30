{config, pkgs, ...}:

{

services.nextcloud = { 
  enable = true; 
  package = pkgs.nextcloud25; 
  extraApps = with pkgs.nextcloud25Packages.apps; {
    inherit mail news contacts;
  };
  extraAppsEnable = true;
  config = {
#  config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}"; 
#  adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
  adminpassFile = "/var/nextcloud-admin-pass";
  adminuser = "admin";
  defaultPhoneRegion = "US";
  };
  hostName = "cloud.ahoneybun.net"; 
  https = true;
};

services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
  forceSSL = true;
  enableACME = true;
};

}
