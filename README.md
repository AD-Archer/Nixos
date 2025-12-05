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

### Security & System Administration
- Firewall enabled (NixOS)
- SSH PermitRootLogin: no
- SSH password auth: false

### Remote Access & Networking
- Allow TCP: 22
- Trusted interfaces: tailscale0

### Development & Specific Services
- Allow TCP: 42000

### Productivity & Integration
- Allow UDP ranges: UDP 1714-1764

## System Packages

Here's a categorization of the NixOS system packages:

### Development & Programming
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

### Command-Line Utilities & Enhancements
- wget
- kitty
- fastfetch
- fzf
- tmux
- curl
- btop
- bat
- zimfw
- gemini-cli
- pokemon-colorscripts

### Productivity & Desktop Tools
- gpaste
- ulauncher
- bitwarden-desktop

## Flatpaks

Here are the Flatpak applications categorized into logical groups:

### Internet / Web Browsers
- app.zen_browser.zen

### Communication
- dev.vencord.Vesktop
- us.zoom.Zoom
- com.slack.Slack

### Utilities
- org.kde.filelight
- com.usebottles.bottles
- com.github.tchx84.Flatseal
- io.gitlab.adhami3310.Impression
- org.gnome.Extensions
- io.github.pwr_solaar.solaar
- org.x.Warpinator
- io.github.giantpinkrobots.flatsweep
- io.github.realmazharhussain.GdmSettings

### Productivity
- org.vinegarhq.Sober
- org.gnome.Todo
- io.github.qwersyk.Newelle

### Multimedia / Graphics
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

Here are the GNOME extensions categorized:

### Productivity & Workflow
- clipboard-indicator
- caffeine
- ulauncher-toggle

### System Utilities & Integration
- appindicator
- gsconnect
- sound-output-device-chooser

### Appearance & UI Customization
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


#### Part 4

Here's a brief summary of the additional changes for today's log:

*   Implemented a fix to ensure the backup service correctly finds `bash` and `git` in its PATH.
*   Continuous progress throughout the day reflected in frequent automated and manual configuration backups.


#### Part 5

Here are the additional changes for today's flake log:

*   Switched to the NixOS default firewall, deprecating the `ufw` configuration.
*   Ensured the backup service has `bash` and `git` available in its PATH.


#### Part 6

Here's a summary of the additional changes for today:

*   Switched to the NixOS default firewall, renaming the configuration file from `ufw.nix` to `firewall.nix`.
*   Ensured the backup service now includes `bash` and `git` in its `PATH`.


#### Part 7

Here are the additional changes for today's NixOS flake log:

*   Switched to the NixOS default firewall and refactored its configuration file.
*   Ensured the backup service's PATH includes `bash` and `git` for proper operation.


#### Part 8

Here are the additional changes for today's NixOS flake log:

*   Switched to the NixOS default firewall, renaming `ufw.nix` to `firewall.nix`.
*   Ensured the backup service has `bash` and `git` correctly configured in its PATH.


#### Part 9

Here's a summary of today's changes:

*   Switched to the NixOS default firewall, renaming `ufw.nix` to `firewall.nix`.
*   Ensured the backup service has `bash` and `git` correctly set in its PATH.
*   Numerous automatic and manual backup commits throughout the day, reflecting continuous progress.
