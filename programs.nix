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
            vscode

            # Work
            virt-manager
            quickemu
            spice
            spice-gtk

            # Streaming
            obs-studio
            ];

}
