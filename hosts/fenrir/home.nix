{
  config,
  pkgs,
  ...
}: {
  home.username = "wyatt";
  home.homeDirectory = "/home/wyatt";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    libreoffice
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "helix";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Services
  services.picom = {
    enable = true;
    shadow = true;
    # shadowOffsets = -7;
    fade = true;
    inactiveOpacity = 0.8;
  };

  #--- Shell ---#
  home.shell.enableBashIntegration = true;
  home.shellAliases = {
    ls = "eza -1 --icons";
    ff = "fastfetch";
    jormungandr = "ssh wyatt@192.168.69.100";
    yt-music = "yt-dlp -x --audio-format opus --replace-in-metadata uploader ' - Topic' '' --parse-metadata '%(playlist_index)s:%(meta_track)s' --parse-metadata '%(uploader)s:%(meta_album_artist)s' --embed-metadata  --format 'bestaudio/best' --audio-quality 0 -o '~/Downloads/Music/%(uploader)s/%(album)s/%(playlist_index)s - %(title)s.%(ext)s' --print '%(uploader)s - %(album)s - %(playlist_index)s %(title)s' --no-simulate";
  };

  #--- Editor ---#
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      languages.language-server = {
        rust-analyzer.config = {
          checkOnSave.allTargets = true;
        };
        nixd = {
          command = "nixd";
          formatting = {
            command = ["alejandra"];
          };
          nixpkgs.expr = "import (builtins.getFlake \"/home/wyatt/Projects/Nix\").inputs.nixpgs { }";
          options.nixos.expr = "(builtins.getFlake \"/home/wyatt/Projects/Nix\").nixosConfigurations.fenrir.options";
        };
      };
    };
  };
}
