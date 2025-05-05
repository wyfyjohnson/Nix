{ config, pkgs, ... }:

{
  home.username = "wyatt";
  home.homeDirectory = "/home/wyatt";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.hello

  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "helix";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Services
  services.picom.enable = true;
}
