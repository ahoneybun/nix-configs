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

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # Add additional package names here
      "vscode"
    ];

  home.packages = with pkgs; [
    # GUI
    #youtube-music
    
    # CLI
    mdbook
    neofetch
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      generations = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      nix-upgrade = "sudo nixos-rebuild switch --upgrade";
    };
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

  programs.command-not-found.enable = true; 

  programs.gh.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
}
