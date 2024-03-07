{ config, pkgs, lib, ... }:

{
  services.jellyfin = {
     enable = true;
     user = "aaronh";
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
