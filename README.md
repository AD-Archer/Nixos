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
- Allow TCP: 22 (for secure remote administration)
- Trusted interfaces: tailscale0 (for secure network extension and remote access management)

### Remote Access & Development
- Allow TCP: 22 (for general remote access to services and environments)
- Allow TCP: 42000 (for specific application or development server access)
- Trusted interfaces: tailscale0 (for secure remote access to development environments or private services)

### Productivity & Integration
- Allow UDP ranges: UDP 1714-1764 (for device integration, e.g., KDE Connect)

## System Packages

Here's a categorization of the NixOS system packages:

### Development Tools
-   gcc
-   lazygit
-   vimPlugins.nvchad
-   gemini-cli
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

### Productivity & System Utilities
-   wget
-   gpaste
-   ulauncher
-   bitwarden-desktop
-   curl
-   fastfetch
-   btop

### Terminal & CLI Enhancements
-   kitty
-   fzf
-   tmux
-   bat
-   zimfw
-   pokemon-colorscripts

## Flatpaks

Here are the Flatpak applications categorized into logical groups:

### Web Browsers
- app.zen_browser.zen

### Communication
- dev.vencord.Vesktop
- us.zoom.Zoom
- com.slack.Slack

### Productivity
- org.gnome.Todo
- io.github.qwersyk.Newelle

### Multimedia & Graphics
- org.gimp.GIMP
- io.gitlab.adhami3310.Impression
- com.obsproject.Studio
- io.github.mhogomchungu.media-downloader

### Gaming
- io.mrarm.mcpelauncher
- com.mojang.Minecraft
- com.pokemmo.PokeMMO
- com.atlauncher.ATLauncher
- com.usebottles.bottles
- io.github.Foldex.AdwSteamGtk

### Utilities
- org.kde.filelight
- org.vinegarhq.Sober
- com.github.tchx84.Flatseal
- com.bitwarden.desktop
- org.gnome.Extensions
- io.github.pwr_solaar.solaar
- org.x.Warpinator
- io.github.giantpinkrobots.flatsweep
- io.github.realmazharhussain.GdmSettings

## GNOME Extensions

Here's a categorization of the GNOME extensions:

### Productivity
-   clipboard-indicator
-   gsconnect
-   caffeine
-   ulauncher-toggle

### Utilities & System Enhancements
-   appindicator
-   sound-output-device-chooser
-   quick-settings-tweaker

### Customization & Visuals
-   just-perfection
-   blur-my-shell

## Ollama Models
- qwen2.5-coder:3b
- hf.co/mradermacher/Dolphin3.0-Qwen2.5-0.5B-GGUF:Q8_0
- hf.co/Qwen/Qwen2.5-Coder-1.5B-Instruct-GGUF:Q4_K_M
- mxbai-embed-large:latest

## Daily Changes


