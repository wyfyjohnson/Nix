
{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-a9033c1c-95f0-47b0-901e-aca315437e9f".device = "/dev/disk/by-uuid/a9033c1c-95f0-47b0-901e-aca315437e9f";
  networking.hostName = "fenrir";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true; # desktop

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true; # desktop
  services.xserver.desktopManager.cinnamon.enable = true; # desktop
  services.xserver.windowManager.qtile.enable = true; # desktop

  # Fonts ### DEFAULTS
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wyatt = {
    isNormalUser = true;
    description = "wyatt";
    extraGroups = [ "input" "video" "libvirtd" "networkmanager" "wheel" ];
    packages = with pkgs; [
     ##they go here##
    ];
  };

  # Install firefox.
  programs.starship.enable = true; # user
  programs.steam.enable = true; # gaming
  programs.kdeconnect.enable = true; # user
  programs.bash = {
    shellAliases = {
      ls = "eza -1 --icons";
      ff = "fastfetch";
      jormungandr = "ssh wyatt@192.168.69.100";
      yt-music = "yt-dlp -x --audio-format opus --replace-in-metadata uploader ' - Topic' '' --parse-metadata '%(playlist_index)s:%(meta_track)s' --parse-metadata '%(uploader)s:%(meta_album_artist)s' --embed-metadata  --format 'bestaudio/best' --audio-quality 0 -o '~/Downloads/Music/%(uploader)s/%(album)s/%(playlist_index)s - %(title)s.%(ext)s' --print '%(uploader)s - %(album)s - %(playlist_index)s %(title)s' --no-simulate";
      # :q = "exit";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    btop # terminal
    cava # terminal
    cmus # terminal
    eza # terminal
    fastfetch # terminal
    flameshot # desktop
    ghostty # default
    git # user
    helix # default
    krabby # terminal
    libreoffice #foobar
    mullvad-vpn # pvt
    nitrogen # desktop
    picom # desktop
    protonup-qt # gaming
    rofi # desktop
    signal-desktop # pvt
    tut # terminal
    vivaldi # default
    webcord # gaming
    wget # terminal
    yt-dlp # terminal
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true; # pvt

  system.stateVersion = "24.11"; # Did you read the comment?

}
