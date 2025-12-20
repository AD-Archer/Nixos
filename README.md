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
- ./apps/firewall.nix
- ./users/root/default.nix
- ./users/arch/default.nix

## Firewall

### Security
- Firewall enabled (NixOS)
- SSH PermitRootLogin: no
- SSH password auth: false

### Connectivity & Remote Access
- Allow TCP: 22
- Trusted interfaces: tailscale0

### Productivity & Utilities
- Allow UDP ranges: UDP 1714-1764 (KDE Connect)

### Development & Custom Services
- Allow TCP: 42000

## System Packages

### Development
- gcc
- dbvisualizer
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
- opencode
- go
- rustc
- cargo
- lua

### Productivity
- gpaste
- ulauncher
- bitwarden-desktop

### Terminal Tools
- kitty
- fzf
- tmux
- bat

### Networking Utilities
- wget
- curl

### System Monitoring
- fastfetch
- btop

### Customization / Fun
- pokemon-colorscripts

## Flatpaks

### Internet & Communication
- app.zen_browser.zen
- dev.vencord.Vesktop
- us.zoom.Zoom
- com.slack.Slack

### System Tools & Utilities
- org.kde.filelight
- org.vinegarhq.Sober
- com.usebottles.bottles
- com.github.tchx84.Flatseal
- com.bitwarden.desktop
- org.gnome.Extensions
- io.github.pwr_solaar.solaar
- org.x.Warpinator
- io.github.giantpinkrobots.flatsweep
- io.github.realmazharhussain.GdmSettings

### Multimedia & Graphics
- org.gimp.GIMP
- io.gitlab.adhami3310.Impression
- io.github.mhogomchungu.media-downloader
- com.obsproject.Studio

### Games
- io.mrarm.mcpelauncher
- com.mojang.Minecraft
- com.pokemmo.PokeMMO
- com.atlauncher.ATLauncher
- io.github.Foldex.AdwSteamGtk

### Productivity
- org.gnome.Todo
- io.github.qwersyk.Newelle

## GNOME Extensions

### Productivity
- clipboard-indicator
- caffeine
- ulauncher-toggle

### System Utilities
- appindicator
- sound-output-device-chooser

### UI Enhancements & Customization
- quick-settings-tweaker
- just-perfection
- blur-my-shell

### Connectivity
- gsconnect

## Ollama Models
- qwen2.5-coder:3b
- hf.co/mradermacher/Dolphin3.0-Qwen2.5-0.5B-GGUF:Q8_0
- hf.co/Qwen/Qwen2.5-Coder-1.5B-Instruct-GGUF:Q4_K_M
- mxbai-embed-large:latest

## Daily Changes


