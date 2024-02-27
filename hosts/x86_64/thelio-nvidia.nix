{ config, pkgs, ... }: 

{
    # Name your host machine
    networking.hostName = "thelio-b1"; 

    # System76
    hardware.system76.enableAll = true;

    # NVIDIA
    services.xserver.videoDrivers = [ "nvidia" ];   
    hardware.opengl.enable = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.nvidia.modesetting.enable = true;

    hardware.opengl = {
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
   };

    # Allow Unfree
    nixpkgs.config.allowUnfree = true;
}
