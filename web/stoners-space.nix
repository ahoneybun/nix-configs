{ config, pkgs, ... }:

{
  services.mastodon = {
    enable = true;
    localDomain = "stoners.space"; # Replace with your own domain
    configureNginx = true;
    smtp.fromAddress = "";
  };

  services.postgresqlBackup = {
    enable = true;
    databases = [ "mastodon" ];
  };

}
