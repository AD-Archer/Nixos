{ config, pkgs, ... }:

{
  imports = [
    ../../modules/hm/quickshell.nix
  ];

  quickshell.enable = true;

  # Home Manager settings
  home.stateVersion = "25.11"; # Pin to a specific version for stability

  # Link configuration files from the 'dotfiles' directory
  home.file = {
    ".config/kitty".source = ../../dotfiles/kitty;
    ".config/nvim".source = ../../dotfiles/nvim;
    ".config/tmux".source = ../../dotfiles/tmux;
    ".ssh/known_hosts".force = true;
    ".ssh/config".force = true;
  };

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

  # SSH managed by Home Manager (config + known_hosts + public key)
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };
  home.file.".ssh/config".source = ../../dotfiles/ssh/config;
  home.file.".ssh/known_hosts".source = ../../dotfiles/ssh/known_hosts;
  home.file.".ssh/id_ed25519".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/ssh/id_ed25519";
  home.file.".ssh/id_ed25519.pub".source = ../../dotfiles/ssh/id_ed25519.pub;

  # Ensure an ssh-agent is available in the session
  services.ssh-agent.enable = true;

  # Let home-manager manage its own files
  programs.home-manager.enable = true;
}
