{ config, pkgs, lib, ... }:
{
  services.flatpak.enable = true;
  services.flatpak.packages = [
    "app.zen_browser.zen"
    "dev.vencord.Vesktop"
    "org.kde.filelight"
    "org.vinegarhq.Sober"
    "com.usebottles.bottles"
    "com.github.tchx84.Flatseal"
    "org.gimp.GIMP"
    "com.bitwarden.desktop"
    "us.zoom.Zoom"
    "io.gitlab.adhami3310.Impression"
    "io.mrarm.mcpelauncher"
    "com.mojang.Minecraft"
    "org.gnome.Extensions"
    "com.slack.Slack"
    "io.github.pwr_solaar.solaar"
    "org.x.Warpinator"
    "io.github.giantpinkrobots.flatsweep"
    "io.github.realmazharhussain.GdmSettings"
    "org.gnome.Todo"
    "com.pokemmo.PokeMMO"
    "io.github.mhogomchungu.media-downloader"
    "com.atlauncher.ATLauncher"
    "io.github.qwersyk.Newelle"
    "io.github.Foldex.AdwSteamGtk"



  ];
  services.flatpak.uninstallUnmanaged = true;  # Removes undeclared apps on rebuild
}

