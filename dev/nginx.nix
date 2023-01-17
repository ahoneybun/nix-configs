    security.acme.acceptTerms = true;
    security.acme.defaults.email = "aaronhoneycutt@proton.me";

    services.nginx = {
      enable = true;
      virtualHosts = {
        "ahoneybun.net" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          root = "/var/www";
        };
      };
    };
  };
