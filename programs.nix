{ config, pkgs, ... }: 

{
    # virt-manager
    virtualisation.libvirtd.enable = true;

    # Packages
    environment.systemPackages = 
       with pkgs; 
         [
            # Comms
            discord
            slack
            signal-desktop

            # Office
            google-chrome
            libreoffice-fresh

            # Work
            virt-manager
            vscode

            # Streaming
            obs-studio
            ];

}
