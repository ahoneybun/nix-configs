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
            signal-deskto

            # Office
            libreoffice-fresh

             # Work
             slack
            virt-manager
            vscode

             # Streaming
            obs-studio
            ];

}
