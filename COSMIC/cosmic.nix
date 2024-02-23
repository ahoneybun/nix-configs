{ unstable, config, pkgs, ... }:

{
  # Enable COSMIC
  services.xserver = {
     enable = true;
     displayManager.cosmic-greeter.enable = true;
     desktopManager.cosmic.enable = true;
  };

  # Grab unstable NixOS packages for using and building COSMIC
  environment.systemPackages = (with pkgs; [
     rustc
     cargo
     cosmic-greeter
  ]);
}
