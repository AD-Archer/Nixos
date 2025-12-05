{ config, pkgs, lib, ... }:

# Minimal Hyprland module copied from temp flake; cleaned to avoid changing DMs or users
{
  config = (lib.mkIf config.hyprlandAddon.enable {
    # If the wrapper sets programs.hyprland, keep it in that module.
    # `hyprlandAddon` imports this module only when the add-on is enabled.
    programs.hyprland = {
      enable = true;
      # safe defaults copied from main configuration; these do not enable DMs or users
      xwayland.enable = true;
      withUWSM = false;
    };

    environment.systemPackages = with pkgs; [
      hyprpaper
      kitty
      libnotify
      mako
      python3
      python3Packages.requests
      qt5.qtwayland
      qt6.qtwayland
      swayidle
      swaylock-effects
      wlogout
      wl-clipboard
      wofi
      waybar
    ];
  }) // (lib.mkIf (config.hyprlandAddon.enable && config.hyprlandAddon.deploySystemConfigs) {
      environment.etc = {
        "xdg/hypr/hyprland.conf" = { source = ./configs/xdg/hypr/hyprland.conf; };
        "xdg/hypr/bind.conf" = { source = ./configs/xdg/hypr/bind.conf; };
        "xdg/hypr/exec.conf" = { source = ./configs/xdg/hypr/exec.conf; };
        "xdg/hypr/monitor.conf" = { source = ./configs/xdg/hypr/monitor.conf; };
        "xdg/hypr/input.conf" = { source = ./configs/xdg/hypr/input.conf; };
        "xdg/hypr/window.conf" = { source = ./configs/xdg/hypr/window.conf; };
        "xdg/hypr/windowrule.conf" = { source = ./configs/xdg/hypr/windowrule.conf; };

        "xdg/waybar/config" = { source = ./configs/xdg/waybar/config; };
        "xdg/waybar/style.css" = { source = ./configs/xdg/waybar/style.css; };
        "xdg/waybar/scripts/waybar-wttr.py" = { source = ./configs/xdg/waybar/scripts/waybar-wttr.py; mode = "0755"; };

        "xdg/wofi/style.css" = { source = ./configs/xdg/wofi/style.css; };

        "xdg/mako/config" = { source = ./configs/xdg/mako/config; };

        "xdg/wlogout/layout" = { source = ./configs/xdg/wlogout/layout; };
        "xdg/wlogout/style.css" = { source = ./configs/xdg/wlogout/style.css; };
        "xdg/wlogout/icons/lock.png" = { source = ./configs/xdg/wlogout/icons/lock.png; };
        "xdg/wlogout/icons/logout.png" = { source = ./configs/xdg/wlogout/icons/logout.png; };
        "xdg/wlogout/icons/suspend.png" = { source = ./configs/xdg/wlogout/icons/suspend.png; };
        "xdg/wlogout/icons/hibernate.png" = { source = ./configs/xdg/wlogout/icons/hibernate.png; };
        "xdg/wlogout/icons/shutdown.png" = { source = ./configs/xdg/wlogout/icons/shutdown.png; };
        "xdg/wlogout/icons/reboot.png" = { source = ./configs/xdg/wlogout/icons/reboot.png; };

        # swayidle/swaylock config may go in /etc/xdg/sway* or left to defaults
        "xdg/sway/swayidle" = { source = ./configs/xdg/sway/swayidle; };
        "xdg/sway/swaylock" = { source = ./configs/xdg/sway/swaylock; };
      };
    });
}
