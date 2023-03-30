{ config, pkgs, ... }:

{
    services.nginx = {
      enable = true;
      virtualHosts = {
      "rockymountainlinuxfest.org" = {
      forceSSL = true;
      enableACME = true;
       locations."/" = {
         root = "/var/www/RMFest-website";
       };
     };
   };
 };

}
