{ config, pkgs, lib, ... }:

{
  imports =
    [
        ./hardware-configuration.nix
        #./home-assistant.nix
    ];

  boot.kernelParams = [ "console=tty0" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nix.settings.extra-platforms = [ "aarch64-linux" ];  
  nix.buildMachines = [{ 
     hostName = "localhost";
     systems = ["x86_64-linux"
                "aarch64-linux"];
     supportedFeatures = ["kvm" "nixos-test" "big-parallel" "benchmark"];
     maxJobs = 8;
  }];

  networking.hostName = "EDI";
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 3000 8123 ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # Enable the OpenSSH daemon.
  services.openssh.settings = {
    PermitRootLogin = "no";
  };

  services.hydra = {
    enable = true;
    hydraURL = "localhost:3000";
    notificationSender = "hydra@localhost";
    useSubstitutes = true;
  };

}
