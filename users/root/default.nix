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
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -l";
      cd = "z"; 
      claer = "clear";
      rebuild = "cd /etc/nixos && sudo nixos-rebuild switch";
    };
    oh-my-zsh = {
      enable = true;
      theme = "refined";
      plugins = [ "git" ]; # Add other plugins here if you wish
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
