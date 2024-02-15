{ config, pkgs, lib, ... }:

{
  imports =
    [
        ./hardware-configuration.nix
    ];

  boot.kernelParams = [ "console=tty0" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nix.settings.extra-platforms = [ "aarch64-linux" ];  
  nix.buildMachines = [{ 
     hostName = "localhost";
     systems = ["x86_64-linux"
                "aarch64-linux"
                "x86_64-darwin"
                "aarch64-darwin"];
     supportedFeatures = ["kvm" "nixos-test" "big-parallel" "benchmark"];
     maxJobs = 8;
  }];

  networking.hostName = "EDI";
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    permitRootLogin = "no";
  };

}
