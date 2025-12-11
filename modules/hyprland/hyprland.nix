{ config, pkgs, lib, ... }:

# Minimal Hyprland module copied from temp flake; cleaned to avoid changing DMs or users
{
  config = lib.mkMerge [
    (lib.mkIf config.hyprlandAddon.enable {
      # If the wrapper sets programs.hyprland, keep it in that module.
      # `hyprlandAddon` imports this module only when the add-on is enabled.
      programs.hyprland = {
        enable = true;
        # safe defaults copied from main configuration; these do not enable DMs or users
        xwayland.enable = true;
        withUWSM = false;
      };
      services.pipewire.enable = true;
      services.pipewire.alsa.enable = true;
      services.pipewire.alsa.support32Bit = true;
      services.pipewire.pulse.enable = true;
      services.pipewire.jack.enable = true;
      services.pipewire.wireplumber.enable = true;
      services.acpid.enable = true;
      services.acpid.lidEventCommands = ''
        /etc/xdg/hypr/lid-lock.sh
      '';

      # Allow hyprlock to authenticate via PAM
      security.pam.services.hyprlock = {};

      environment.systemPackages = with pkgs; [
        hyprpaper
        kitty
        libnotify
        mako
        python3
        python3Packages.requests
        python3Packages.pip
        qt5.qtwayland
        qt6.qtwayland
        swayidle
        swaylock-effects
        wlogout
        wl-clipboard
        wofi
        waybar
        waypaper
        playerctl
        brightnessctl
        pamixer
        pavucontrol
      ];
    })
    (lib.mkIf (config.hyprlandAddon.enable && config.hyprlandAddon.deploySystemConfigs) {
      environment.etc = {
        "xdg/hypr/hyprland.conf" = { source = ./configs/xdg/hypr/hyprland.conf; };
        "xdg/hypr/bind.conf" = { source = ./configs/xdg/hypr/bind.conf; };
        "xdg/hypr/exec.conf" = { source = ./configs/xdg/hypr/exec.conf; };
        "xdg/hypr/monitor.conf" = { source = ./configs/xdg/hypr/monitor.conf; };
        "xdg/hypr/input.conf" = { source = ./configs/xdg/hypr/input.conf; };
        "xdg/hypr/window.conf" = { source = ./configs/xdg/hypr/window.conf; };
        "xdg/hypr/windowrule.conf" = { source = ./configs/xdg/hypr/windowrule.conf; };
        "xdg/hypr/hyprlock.conf" = { source = ./configs/xdg/hypr/hyprlock.conf; };
        "xdg/hypr/lid-lock.sh" = {
          source = pkgs.writeShellScript "lid-lock.sh" ''
            USER_NAME=arch
            USER_UID=$(id -u "$USER_NAME" 2>/dev/null) || exit 0
            RUNTIME_DIR="/run/user/$USER_UID"
            [ -d "$RUNTIME_DIR" ] || exit 0

            should_lock_for_lid() {
              local lid_state_file state
              lid_state_file=$(find /proc/acpi/button -path '*/state' -type f 2>/dev/null | head -n1)
              if [ -n "$lid_state_file" ]; then
                state=$(awk '{print $2}' "$lid_state_file" 2>/dev/null | tr '[:upper:]' '[:lower:]')
                if [ "$state" = "open" ]; then
                  return 1
                fi
              fi
              return 0
            }

            # Ignore lid-open events so we do not immediately re-lock after resume
            should_lock_for_lid || exit 0

            # Try to read the active Hyprland session's WAYLAND_DISPLAY for reliability
            get_wayland_display() {
              local hypr_pid
              hypr_pid=$(pgrep -u "$USER_NAME" -x Hyprland | head -n1)
              if [ -n "$hypr_pid" ] && [ -r "/proc/$hypr_pid/environ" ]; then
                tr '\0' '\n' < "/proc/$hypr_pid/environ" | sed -n 's/^WAYLAND_DISPLAY=//p' | head -n1
              fi
            }

            WAYLAND_DISPLAY=$(get_wayland_display)
            if [ -z "$WAYLAND_DISPLAY" ]; then
              WAYLAND_DISPLAY=$(ls "$RUNTIME_DIR"/wayland-* 2>/dev/null | head -n1 | xargs -r basename)
            fi
            [ -n "$WAYLAND_DISPLAY" ] || exit 0

            export XDG_RUNTIME_DIR="$RUNTIME_DIR"
            export WAYLAND_DISPLAY
            export PATH="/run/current-system/sw/bin:$PATH"

            # Avoid spawning multiple hyprlock instances
            pgrep -u "$USER_NAME" -x hyprlock >/dev/null 2>&1 && exit 0

            # Run hyprlock as the user in the active session
            runuser -u "$USER_NAME" -- env XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" WAYLAND_DISPLAY="$WAYLAND_DISPLAY" hyprlock
          '';
          mode = "0755";
        };

        "xdg/waybar/config" = { source = ./configs/xdg/waybar/config.jsonc; };
        "xdg/waybar/modules.jsonc" = { source = ./configs/xdg/waybar/modules.jsonc; };
        "xdg/waybar/style.css" = { source = ./configs/xdg/waybar/style.css; };

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
    })
  ];
}
