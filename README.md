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

### System & Security
- Firewall enabled (NixOS)
- SSH PermitRootLogin: no
- SSH password auth: false

### Networking & Remote Access
- Allow TCP: 22 (SSH)
- Trusted interfaces: tailscale0

### Productivity & Device Integration
- Allow UDP ranges: UDP 1714-1764 (KDE Connect)

### Custom Services & Development
- Allow TCP: 42000

## System Packages

### Programming Languages & Runtimes
- nodejs
- python3
- go
- rustc
- lua

### Development Tools
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
- vscode
- opencode
- cargo

### Utilities
- wget
- fastfetch
- gpaste
- fzf
- ulauncher
- curl
- btop
- bat

### Terminals & Shells
- kitty
- tmux

### Productivity
- bitwarden-desktop

### Customization & Fun
- pokemon-colorscripts

## Flatpaks

### Productivity & Internet
- app.zen_browser.zen
- com.bitwarden.desktop
- org.gnome.Todo
- io.github.qwersyk.Newelle

### Communication
- dev.vencord.Vesktop
- us.zoom.Zoom
- com.slack.Slack

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

### Multimedia
- org.gimp.GIMP
- io.github.mhogomchungu.media-downloader
- com.obsproject.Studio

### Gaming
- io.mrarm.mcpelauncher
- com.mojang.Minecraft
- com.pokemmo.PokeMMO
- com.atlauncher.ATLauncher
- io.github.Foldex.AdwSteamGtk

## GNOME Extensions

### Productivity
- clipboard-indicator
- caffeine
- ulauncher-toggle

### System Utilities & Connectivity
- appindicator
- gsconnect
- sound-output-device-chooser

### System Customization & Appearance
- quick-settings-tweaker
- just-perfection
- blur-my-shell

## Ollama Models
- qwen2.5-coder:3b
- hf.co/mradermacher/Dolphin3.0-Qwen2.5-0.5B-GGUF:Q8_0
- hf.co/Qwen/Qwen2.5-Coder-1.5B-Instruct-GGUF:Q4_K_M
- mxbai-embed-large:latest

## Daily Changes


### 2025-12-19
<!-- last_hash:406c85907f655143b6516c385a4e1d7241b13058 -->

Here are today's NixOS flake changes:

*   A routine automated backup of the NixOS flake configuration was executed.
*   The backup, identified by commit `acd3d66`, was timestamped at `2025-12-20T02:40:49Z`.
*   This activity by `ad-archer` ensures the current flake state is preserved as part of ongoing system maintenance.

Highlight: Automated flake configuration backup completed.


#### Part 2

Here's an update to your flake log summary:

- Automatic flake backup on 2025-12-20.
