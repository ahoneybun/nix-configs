{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./unstable.nix
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
  boot.loader.grub.version = 2;
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

  fileSystems."/mnt/swapfile" =
    { device = "/dev/disk/by-uuid/82672991-fe8a-485a-8dcf-7c8ae1282b6c";
      fsType = "ext4";
    };

  services.hydra = {
    enable = true;
    hydraURL = "localhost:3000";
    notificationSender = "hydra@localhost";
    #buildMachinesFiles = [];
    useSubstitutes = true;
  };

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "aaronhoneycutt@proton.me";
  
  networking.hostName = "nixos-server"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aaronh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      cargo
      flatpak
      git
      git-lfs
      just
    ];
  };

  users.users.nathanielw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      neofetch
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
    toybox
    tree
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.usePredictableInterfaceNames = false;
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
