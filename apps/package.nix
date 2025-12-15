{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    kitty
    gcc
    fastfetch
    gpaste
    ulauncher
    pokemon-colorscripts
    fzf
    bitwarden-desktop

    # Terminal tools
    tmux
    curl
    btop
    bat
    lazygit
    vimPlugins.nvchad
    zimfw
    gemini-cli

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
