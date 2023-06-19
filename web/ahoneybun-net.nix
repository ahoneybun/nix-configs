{ config, pkgs, ... }:

{
    services.nginx = {
      enable = true;
      virtualHosts = {
      "ahoneybun.net" = {
      forceSSL = true;
      enableACME = true;
       locations."/" = {
         root = "/var/www/ahoneybun-net/_site";
       };
     };
   };
 };

}
