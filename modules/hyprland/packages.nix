{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.hyprlandAddon.enable {
    environment.systemPackages = with pkgs; [
    bat
    btop
    eza
    fzf
    git
    gnumake
    lm_sensors
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    neofetch
    neovim
    ripgrep
    tldr
    unzip
    openssl
    swaylock
    openssl.dev
    pkg-config
    waypaper
    hyprpaper
    wget
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    zip
    zoxide
    networkmanagerapplet
    blueman
    networkmanager_dmenu
    feishin
    rofi
    (python3.withPackages (ps: with ps; [ requests ]))
    hyprlock
    hypridle
    hyprshot
    # Clipboard manager (copy/paste history)
    copyq

    # Mail client
    thunderbird

    # GNOME keyring (secrets/ssh integration)
    gnome-keyring
    ];
  };
}
