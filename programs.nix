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
            signal-desktop

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
