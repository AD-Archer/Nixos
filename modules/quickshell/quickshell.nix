{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.quickshell;
  quickshellConfig = pkgs.runCommandLocal "quickshell-config" { } ''
    mkdir -p $out
    cp -r --no-preserve=mode,ownership ${inputs.illogical-impulse-dotfiles}/.config/quickshell/* $out/
    chmod -R u+rwX $out
    mkdir -p $out/ii/modules/common
    install -m644 -T ${./quickshell/Appearance.qml} $out/ii/modules/common/Appearance.qml
  '';
in {
  options.quickshell.enable = lib.mkEnableOption "Enable QuickShell bar setup";

  config = lib.mkIf cfg.enable {
    # GTK/Qt are handled by the user's session or system configuration.
    # Keep only Home Manager settings below.

    home.sessionVariables = {
      ILLOGICAL_IMPULSE_VIRTUAL_ENV = "~/.local/state/quickshell/.venv";
      QS_CONFIG_NAME = "ii"; # Default QuickShell configuration directory to run
      # Ensure QuickShell and other Qt apps use US month/day date formatting
      LC_TIME = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
      # Cursor theme (set to a sensible default; install a matching cursor package if needed)
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE = "24";
    };

    home.packages = with pkgs; [
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      kdePackages.kdialog
      kdePackages.qt5compat
      kdePackages.qtbase
      kdePackages.qtdeclarative
      kdePackages.qtimageformats
      kdePackages.qtmultimedia
      kdePackages.qtpositioning
      kdePackages.qtquicktimeline
      kdePackages.qtsensors
      kdePackages.qtsvg
      kdePackages.qttools
      kdePackages.qttranslations
      kdePackages.qtvirtualkeyboard
      kdePackages.qtwayland
      kdePackages.syntax-highlighting
      # Fonts for icons/text used by the QuickShell theme
      material-symbols
      google-fonts
      nerd-fonts.space-mono
      nerd-fonts.jetbrains-mono
    ];

    xdg.configFile."quickshell".source = quickshellConfig;
  };
}
