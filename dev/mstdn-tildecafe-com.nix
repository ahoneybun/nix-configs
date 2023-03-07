{ config, pkgs, ... }:

{
  services.mastodon = {
    enable = true;
    localDomain = "mstdn.tildecafe.com"; # Replace with your own domain
    configureNginx = true;
    smtp.fromAddress = "aaronhoneycutt@proton.me"; # Email address used by Mastodon to send emails, replace with your own
    extraConfig.SINGLE_USER_MODE = "true";
  };

  services.postgresqlBackup = {
    enable = true;
    databases = [ "mastodon" ];
  };

}
