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

### System Security
- Firewall enabled (NixOS)
- SSH PermitRootLogin: no
- SSH password auth: false

### Remote Access & Networking
- Allow TCP: 22 (Standard SSH access)
- Trusted interfaces: tailscale0 (Secure VPN for remote access)

### Development & Custom Services
- Allow TCP: 42000 (Indicates a custom application or development server)

### Desktop Productivity & Integration
- Allow UDP ranges: UDP 1714-1764 (KDE Connect for desktop-mobile integration)

## System Packages

Here are the NixOS system packages categorized into logical groups:

### Development Tools & Languages
-   gcc
-   dbvisualizer
-   lazygit
-   vimPlugins.nvchad
-   codex
-   nodePackages.vercel
-   code-cursor
-   git
-   neovim
-   pnpm
-   nodejs
-   vscode
-   python3
-   opencode
-   go
-   rustc
-   cargo
-   lua

### Terminal Emulators & Enhancements
-   kitty
-   pokemon-colorscripts
-   fzf
-   tmux
-   bat

### System Utilities & Information
-   fastfetch
-   btop

### Productivity & Desktop Enhancements
-   gpaste
-   bitwarden-desktop
-   ulauncher

### Networking & File Transfer
-   wget
-   curl

## Flatpaks

Here's a categorization of the provided Flatpak applications:

### Web Browsers
- app.zen_browser.zen

### Communication & Social
- dev.vencord.Vesktop
- us.zoom.Zoom
- com.slack.Slack

### Productivity
- org.vinegarhq.Sober
- io.gitlab.adhami3310.Impression
- org.gnome.Todo
- io.github.qwersyk.Newelle

### Multimedia & Graphics
- org.gimp.GIMP
- io.github.mhogomchungu.media-downloader
- com.obsproject.Studio

### Gaming
- io.mrarm.mcpelauncher
- com.mojang.Minecraft
- com.pokemmo.PokeMMO
- com.atlauncher.ATLauncher
- io.github.Foldex.AdwSteamGtk

### Utilities & System Tools
- org.kde.filelight
- com.usebottles.bottles
- com.github.tchx84.Flatseal
- com.bitwarden.desktop
- org.gnome.Extensions
- io.github.pwr_solaar.solaar
- org.x.Warpinator
- io.github.giantpinkrobots.flatsweep
- io.github.realmazharhussain.GdmSettings

## GNOME Extensions

### Productivity
- caffeine
- clipboard-indicator
- ulauncher-toggle

### Utilities & Integration
- appindicator
- gsconnect
- sound-output-device-chooser

### Customization & Aesthetics
- blur-my-shell
- just-perfection
- quick-settings-tweaker

## Ollama Models
- qwen2.5-coder:3b
- hf.co/mradermacher/Dolphin3.0-Qwen2.5-0.5B-GGUF:Q8_0
- hf.co/Qwen/Qwen2.5-Coder-1.5B-Instruct-GGUF:Q4_K_M
- mxbai-embed-large:latest
## Daily Changes

### 2025-12-19
<!-- last_hash:acd3d669cb9b456d4e8838e3d13437c108e88a27 -->

Here are today's NixOS flake changes:

*   A routine automated backup of the NixOS flake configuration was executed.
*   The backup, identified by commit `acd3d66`, was timestamped at `2025-12-20T02:40:49Z`.
*   This activity by `ad-archer` ensures the current flake state is preserved as part of ongoing system maintenance.

Highlight: Automated flake configuration backup completed.