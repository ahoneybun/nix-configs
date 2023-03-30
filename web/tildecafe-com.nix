{ config, pkgs, ... }:

{
    services.nginx = {
      enable = true;
      virtualHosts = {
      "tildecafe.com" = {
      forceSSL = true;
      enableACME = true;
       locations."/" = {
         root = "/var/www/tildecafe";
       };
     };
   };
 };

}
