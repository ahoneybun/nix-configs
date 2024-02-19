{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aaronh";
  home.homeDirectory = "/home/aaronh";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    # GUI
    deja-dup
    discord
    libreoffice-fresh
    signal-desktop
    tuba
    #youtube-music
    
    # CLI
    btop
    freshfetch
    gcc
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      nix-generations = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      nix-upgrade = "sudo nixos-rebuild switch --upgrade";
    };
    bashrcExtra = "eval `ssh-agent`\n
                   ssh-add ~/.ssh/protonmail\n
                   ssh-add ~/.ssh/system76";
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Aaron Honeycutt";
    userEmail = "aaronhoneycutt@protonmail.com";
    aliases = {
       undo = "reset HEAD~1 --mixed";
       amend = "commit -a --amend";
       feature = "commit -m feat: -m new-feature";
       fix = "commit -m fix: -m issue#";
    };
    extraConfig = {
      color = {
         ui = "auto";
      };
      color.status = {
         added = "green bold";
         changed = "yellow bold";
         untracked = "red bold";
      };
      push = {
         autoSetupRemote = "true";
      };
      init = {
          defaultBranch = "main";
      };
    };
  };
  
  programs.nix-index = {
     enable = true;
     enableBashIntegration = true;
  };  

  programs.vscode = {
     enable = true;
     package = pkgs.vscodium;
     extensions = with pkgs.vscode-extensions; [
        yzhang.markdown-all-in-one
     ];
  };
  
  dconf.settings = { 
     "org/gnome/shell" = {
        favorite-apps = [ "nautilus.desktop" "org.gnome.Console.desktop" "firefox.desktop" "codium.desktop" "signal-desktop.desktop" ];
     };
     "org/gnome/desktop/background" = {
       picture-uri-dark = "file:///home/aaronh/Pictures/Walls/wallhaven-2y2wg6.png";
     };
     "org/gnome/desktop/interface" = {
        clock-show-seconds = true;
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
     };
     "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
     };
     "org/gnome/desktop/vm/keybindings" = {
        close = ["<Super>q"];
     };
  };

  programs.gh.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
}
