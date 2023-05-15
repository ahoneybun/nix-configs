{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./unstable.nix
      ./stoners-space.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "console=ttyS0,19200n8" ];
  
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nix.settings.extra-platforms = [ "aarch64-linux" ];
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.buildMachines = [{ 
     hostName = "localhost";
     systems = ["x86_64-linux"
                "aarch64-linux"
                "x86_64-darwin"
                "aarch64-darwin"];
     supportedFeatures = ["kvm" "nixos-test" "big-parallel" "benchmark"];
     maxJobs = 8;
  }];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.extraConfig = ''
    serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
    terminal_input serial;
    terminal_output serial
  '';
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.loader.timeout = 10;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };

  networking.extraHosts = 
    ''
      23.32.241.51 r3.o.lencr.org
    '';

  # fileSystems."/mnt/swapfile" =
  #   { device = "/dev/disk/by-uuid/82672991-fe8a-485a-8dcf-7c8ae1282b6c";
  #     fsType = "ext4";
  #   };

  # services.hydra = {
  #   enable = true;
  #   hydraURL = "localhost:3000";
  #   notificationSender = "hydra@localhost";
  #   useSubstitutes = true;
  # };

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "aaronhoneycutt@proton.me";
  
  networking.hostName = "sovereign";

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aaronh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      cargo
      git
      git-lfs
    ];
  };

  users.users.builder = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      neofetch 
    ];
  };

  environment.systemPackages = with pkgs; [
    acme-sh
    git
    inetutils
    mtr
    neofetch
    sysstat
    tree
    wget
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
  };

  networking.usePredictableInterfaceNames = false;
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  system.stateVersion = "22.11"; # Did you read the comment?
  system.autoUpgrade.enable = true;
}

