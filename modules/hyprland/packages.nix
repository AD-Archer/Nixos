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
    waybar
    waypaper
    hyprpaper
    wget
    xfce.thunar
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    zip
    zoxide
    ];
  };
}
