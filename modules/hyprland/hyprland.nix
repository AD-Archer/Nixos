{ config, pkgs, lib, ... }:

# Minimal Hyprland module copied from temp flake; cleaned to avoid changing DMs or users
let
  hyprConfig = ./configs/xdg/hypr;
in {
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

      # Start hypridle in the user session to manage idle locking and suspend hooks
      systemd.user.services.hypridle = {
        description = "Hyprland idle daemon (hypridle)";
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.hypridle}/bin/hypridle --config /etc/xdg/hypr/hypridle.conf";
          Restart = "always";
        };
      };

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
        waypaper
        playerctl
        brightnessctl
        pamixer
        pavucontrol
      ];
    })
    (lib.mkIf (config.hyprlandAddon.enable && config.hyprlandAddon.deploySystemConfigs) {
      environment.etc."xdg/hypr".source = hyprConfig;
    })
  ];
}
