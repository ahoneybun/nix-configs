    security.acme.acceptTerms = true;
    security.acme.defaults.email = "aaronhoneycutt@proton.me";

    services.nginx = {
      enable = true;
      virtualHosts = {
        "ahoneybun.net" = {
        forceSSL = true;
        enableACME = true;
        # All serverAliases will be added as extra domain names on the certificate.
#        serverAliases = [ "bar.example.com" ];
        locations."/" = {
          root = "/var/www";
        };
      };
    };
  };
