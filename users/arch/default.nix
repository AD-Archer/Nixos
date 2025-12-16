{ config, pkgs, osConfig ? {}, ... }:

let
  hyprAddonEnabled = (osConfig ? hyprlandAddon) && (osConfig.hyprlandAddon.enable or false);
in

{
  imports = [
    ../../modules/quickshell/quickshell.nix
  ];

  quickshell.enable = hyprAddonEnabled;

  # Home Manager settings
  home.stateVersion = "25.11"; # Pin to a specific version for stability

  # Link configuration files from the 'dotfiles' directory
  home.file = {
    ".config/kitty".source = ../../dotfiles/kitty;
    ".config/nvim".source = ../../dotfiles/nvim;
    ".config/tmux".source = ../../dotfiles/tmux;
    ".config/hypr".source = ../../modules/hyprland/configs/xdg/hypr;
    # Note: SSH config/keys are managed outside Home Manager now
  };

  # Install helper scripts into the user's local bin
  home.file.".local/bin/update-quickshell.sh".source = /etc/nixos/scripts/update-quickshell.sh;
  home.file.".local/bin/update-system.sh".source = /etc/nixos/scripts/update-system.sh;
  # Ensure scripts are executable when managed by home manager
  home.file.".local/bin/update-quickshell.sh".mode = "0755";
  home.file.".local/bin/update-system.sh".mode = "0755";

  # Configure Zsh with Oh My Zsh and Powerlevel10k theme
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
      styles = {
        command = "fg=green";
        builtin = "fg=cyan";
        alias = "fg=yellow";
        path = "fg=blue";
        "reserved-word" = "fg=magenta";
      };
    };
    plugins = [
      { name = "zsh-history-substring-search"; src = pkgs.zsh-history-substring-search; }
      { name = "zsh-you-should-use"; src = pkgs.zsh-you-should-use; }
      { name = "zsh-nix-shell"; src = pkgs.zsh-nix-shell; }
    ];
    shellAliases = {
      ll = "ls -l";
      cd = "z"; 
      oc = "opencode";
      claer = "clear";
      rebuild = "cd /etc/nixos && sudo nixos-rebuild switch";
    };
    oh-my-zsh = {
      enable = true;
      theme = "refined";
      plugins = [
        "git"
        "docker"
        "docker-compose"
        "kubectl"
        "colored-man-pages"
        "extract"
        "history-substring-search"
        "sudo"
      ];
    };
    initContent = ''
      if [[ $- == *i* ]]; then
        pokemon-colorscripts --no-title -b -n charizard -f mega-y -s | fastfetch --logo -
      fi
      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
    '';
  };

  # Enable Zoxide for smarter directory navigation
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Git identity (managed by Home Manager instead of manual global config)
  programs.git = {
    enable = true;
    settings = {
      user.name = "ad-archer";
      user.email = "antonioarcher.dev@gmail.com";
    };
  };

  # SSH is handled by the system/user directly (not Home Manager)

  # Let home-manager manage its own files
  programs.home-manager.enable = true;
}
