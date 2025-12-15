{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.quickshell;
  quickshellConfig = pkgs.runCommandLocal "quickshell-config" { } ''
    mkdir -p $out
    cp -r ${inputs.illogical-impulse-dotfiles}/.config/quickshell/* $out/
    cp ${./quickshell/Appearance.qml} $out/ii/modules/common/Appearance.qml
    chmod -R u+rwX $out
  '';
in {
  options.quickshell.enable = lib.mkEnableOption "Enable QuickShell bar setup";

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "kde";
    };

    home.sessionVariables = {
      ILLOGICAL_IMPULSE_VIRTUAL_ENV = "~/.local/state/quickshell/.venv";
      QS_CONFIG_NAME = "ii"; # Default QuickShell configuration directory to run
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
    ];

    xdg.configFile."quickshell".source = quickshellConfig;
  };
}
