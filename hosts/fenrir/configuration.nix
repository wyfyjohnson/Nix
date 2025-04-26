
{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-a9033c1c-95f0-47b0-901e-aca315437e9f".device = "/dev/disk/by-uuid/a9033c1c-95f0-47b0-901e-aca315437e9f";
  networking.hostName = "fenrir"; # Define your hostname.
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
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.windowManager.qtile.enable = true;

  # Fonts
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
    #  thunderbird
    ];
  };

  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   users = {
  #     "wyatt" = import ./home.nix;
  #   };
  # };

  # Install firefox.
  programs.starship.enable = true;
  programs.steam.enable = true;
  programs.kdeconnect.enable = true;
  programs.bash = {
    shellAliases = {
      ls = "eza -1 --icons";
      ff = "fastfetch";
      jormungandr = "ssh wyatt@192.168.69.100";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    btop
    cava
    cmus
    eza
    fastfetch
    ghostty
    git
    helix
    krabby
    libreoffice
    mullvad-vpn
    nitrogen
    picom
    rofi
    signal-desktop
    tut
    vivaldi
    webcord
    wget
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

services.avahi = {
  enable = true;
  nssmdns4 = true;
  openFirewall = true;
};
  system.stateVersion = "24.11"; # Did you read the comment?

}
