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
  home.stateVersion = "22.11";

  nixpkgs.config.allowUnfree = true; 

  home.packages = with pkgs; [
    element-desktop
    fish
    fishPlugins.grc
    foliate
    fractal
    git
    git-lfs
    keybase-gui
    neofetch
    watchmate
    vscode
  ];

  programs.fish = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Aaron Honeycutt";
    userEmail = "aaronhoneycutt@protonmail.com";
    aliases = {
       undo = "reset HEAD~1 --mixed";
       amend = "commit -a --amend";
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
    };
  };

  programs.command-not-found.enable = true; 

  programs.firefox.enable = true;
  programs.gh.enable = true;


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
