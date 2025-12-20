{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    kitty
    gcc
    fastfetch
    gpaste
    pokemon-colorscripts
    fzf
    ulauncher
    bitwarden-desktop
    dbvisualizer

    # Terminal tools
    tmux
    curl
    btop
    bat
    lazygit
    vimPlugins.nvchad

    # Dev
    codex
    nodePackages.vercel
    code-cursor
    git
    neovim
    pnpm
    nodejs
    vscode
    python3
    opencode
    go
    rustc
    cargo
    lua
  ];
}
