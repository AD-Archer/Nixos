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

### Development Tools
- gcc
- lazygit
- vimPlugins.nvchad
- codex
- nodePackages.vercel
- code-cursor
- git
- neovim
- pnpm
- nodejs
- vscode
- python3
- go
- rustc
- cargo
- lua

### Productivity & Office
- gpaste
- ulauncher
- bitwarden-desktop

### System Utilities
- wget
- kitty
- fastfetch
- fzf
- Terminal
- tools
- tmux
- curl
- btop
- bat
- zimfw
- gemini-cli

### Customization & Fun
- pokemon-colorscripts

## Flatpaks

### Internet & Web Browsers
- app.zen_browser.zen

### Communication
- dev.vencord.Vesktop
- us.zoom.Zoom
- com.slack.Slack

### Productivity
- org.gnome.Todo
- io.github.qwersyk.Newelle

### Graphics & Multimedia
- org.gimp.GIMP
- com.obsproject.Studio
- io.github.jeffshee.Hidamari

### Gaming
- io.mrarm.mcpelauncher
- com.mojang.Minecraft
- com.pokemmo.PokeMMO
- com.atlauncher.ATLauncher
- io.github.Foldex.AdwSteamGtk

### Utilities
- org.kde.filelight
- org.vinegarhq.Sober
- com.usebottles.bottles
- com.github.tchx84.Flatseal
- io.gitlab.adhami3310.Impression
- org.gnome.Extensions
- io.github.pwr_solaar.solaar
- org.x.Warpinator
- io.github.giantpinkrobots.flatsweep
- io.github.realmazharhussain.GdmSettings
- io.github.mhogomchungu.media-downloader

## GNOME Extensions

### Productivity
- caffeine
- clipboard-indicator
- ulauncher-toggle

### System Utilities & UI Management
- appindicator
- sound-output-device-chooser

### Connectivity & Integration
- gsconnect

### Customization & Aesthetics
- just-perfection
- quick-settings-tweaker
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


#### Part 2

Here are the additional changes for today's NixOS flake log:

*   Ensured the backup service has `bash` and `git` in its PATH for proper operation.
*   Numerous automated backups were committed throughout the day, reflecting continuous development.
*   Several manual progress checkpoints, notably "12/5/25 12.35AM" and "12/5/25 12.50AM", were recorded by different contributors.


#### Part 3

Here's a summary of the additional changes:

*   The backup service was updated to ensure `bash` and `git` are correctly included in its PATH.
*   Multiple manual commits in the early morning likely reflect significant configuration adjustments.
*   Numerous automated backups were performed throughout the day, capturing the flake's evolving state.
