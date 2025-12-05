# NixOS Flake Overview (hypr)

## System
- Hostname: hypr
- Timezone: America/New_York
- Desktop: GNOME (GDM)

## Modules
- ./configuration.nix
- ./apps/package.nix
- ./apps/flatpaks.nix
- ./apps/gnome-extensions.nix
- ./apps/gnome-custom.nix
- ./apps/ollama.nix
- ./users/root/default.nix
- ./users/arch/default.nix

## System Packages

Here's a categorization of the NixOS system packages:

### Development
-   cargo
-   codex
-   code-cursor
-   gcc
-   git
-   go
-   lazygit
-   lua
-   neovim
-   nodePackages.vercel
-   nodejs
-   pnpm
-   python3
-   rustc
-   vimPlugins.nvchad
-   vscode

### Productivity
-   bitwarden-desktop
-   gpaste
-   ulauncher

### Utilities
-   bat
-   btop
-   curl
-   fastfetch
-   fzf
-   gemini-cli
-   kitty
-   tmux
-   wget
-   zimfw

### Fun & Entertainment
-   pokemon-colorscripts

## Flatpaks

### Internet & Communication
-   app.zen_browser.zen
-   dev.vencord.Vesktop
-   us.zoom.Zoom
-   com.slack.Slack

### Productivity
-   org.gnome.Todo
-   io.github.qwersyk.Newelle

### Utilities & System Tools
-   org.kde.filelight
-   org.vinegarhq.Sober
-   com.usebottles.bottles
-   com.github.tchx84.Flatseal
-   org.gnome.Extensions
-   io.github.pwr_solaar.solaar
-   org.x.Warpinator
-   io.github.giantpinkrobots.flatsweep
-   io.github.realmazharhussain.GdmSettings

### Graphics & Multimedia
-   org.gimp.GIMP
-   io.gitlab.adhami3310.Impression
-   io.github.mhogomchungu.media-downloader
-   com.obsproject.Studio

### Gaming
-   io.mrarm.mcpelauncher
-   com.mojang.Minecraft
-   com.pokemmo.PokeMMO
-   com.atlauncher.ATLauncher
-   io.github.Foldex.AdwSteamGtk

## GNOME Extensions

### Productivity & Workflow
- clipboard-indicator
- caffeine
- ulauncher-toggle

### System & Connectivity
- appindicator
- gsconnect
- sound-output-device-chooser

### Customization & UI Tweaks
- quick-settings-tweaker
- just-perfection
- blur-my-shell

## Ollama Models
- qwen2.5-coder:3b
- hf.co/mradermacher/Dolphin3.0-Qwen2.5-0.5B-GGUF:Q8_0
- hf.co/Qwen/Qwen2.5-Coder-1.5B-Instruct-GGUF:Q4_K_M
- mxbai-embed-large:latest

## Daily Changes














### 2025-12-05

Here's a summary of today's NixOS flake changes:

*   Resolved an issue with the backup service by explicitly adding bash and git to its PATH, enhancing its reliability.
*   Manual configuration updates were committed in the early morning by arch, signaling general progress on the flake.
*   Numerous auto-backup snapshots were recorded throughout the day by both arch and ad-archer.

Highlight: Backup service PATH dependency addressed for stability.
