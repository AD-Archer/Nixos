{ config, pkgs, ... }:

{
  # Home Manager settings
  home.stateVersion = "25.11"; # Pin to a specific version for stability

  # Link configuration files from the 'dotfiles' directory
  home.file = {
    ".config/kitty".source = ../../dotfiles/kitty;
    ".config/nvim".source = ../../dotfiles/nvim;
    ".config/tmux".source = ../../dotfiles/tmux;
  };

  # Configure Zsh with Oh My Zsh and Powerlevel10k theme
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    plugins = [
      { name = "zsh-autosuggestions"; src = pkgs.zsh-autosuggestions; }
      { name = "zsh-completions"; src = pkgs.zsh-completions; }
      { name = "zsh-syntax-highlighting"; src = pkgs.zsh-syntax-highlighting; }
      { name = "zsh-history-substring-search"; src = pkgs.zsh-history-substring-search; }
      { name = "zsh-you-should-use"; src = pkgs.zsh-you-should-use; }
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
        "nix-shell"
        "colored-man-pages"
        "extract"
        "history-substring-search"
        "sudo"
      ];

    };
  };

  # Enable Zoxide for smarter directory navigation
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Let home-manager manage its own files
  programs.home-manager.enable = true;
}
