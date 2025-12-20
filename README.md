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
- Trusted interfaces: tailscale0
- SSH PermitRootLogin: no
- SSH password auth: false

### Development & System Administration
- Allow TCP: 22 (SSH)
- Allow TCP: 42000 (Custom application/development port)

### Productivity & Device Integration
- Allow UDP ranges: UDP 1714-1764 (KDE Connect)

## System Packages

Here's a categorization of the NixOS system packages:

### Development Tools
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

### Terminal & Shell Enhancements
-   kitty
-   fzf
-   Terminal
-   tmux
-   bat

### Utilities
-   wget
-   fastfetch
-   gpaste
-   ulauncher
-   tools
-   curl
-   btop

### Productivity & Security
-   bitwarden-desktop

### Customization & Fun
-   pokemon-colorscripts

## Flatpaks

### Browsers
- app.zen_browser.zen

### Communication
- dev.vencord.Vesktop
- com.slack.Slack
- us.zoom.Zoom

### Development
- com.getpostman.Postman

### Productivity
- org.onlyoffice.desktopeditors
- org.gnome.Todo
- io.github.qwersyk.Newelle

### Multimedia
- com.obsproject.Studio
- org.gimp.GIMP
- dev.fredol.open-tv
- io.github.yuki_iptv.yuki-iptv
- io.github.mhogomchungu.media-downloader

### Gaming
- io.github.Foldex.AdwSteamGtk
- org.vinegarhq.Sober
- com.usebottles.bottles
- io.mrarm.mcpelauncher
- com.mojang.Minecraft
- com.pokemmo.PokeMMO
- com.atlauncher.ATLauncher

### Utilities
- com.bitwarden.desktop
- io.gitlab.adhami3310.Impression
- org.kde.filelight
- com.github.tchx84.Flatseal
- io.github.giantpinkrobots.flatsweep
- io.github.realmazharhussain.GdmSettings
- org.gnome.Extensions
- io.github.pwr_solaar.solaar
- org.x.Warpinator

## GNOME Extensions

Here's a categorization of the GNOME extensions:

### System Utilities & Integration
- appindicator
- gsconnect
- sound-output-device-chooser

### Productivity & Workflow
- clipboard-indicator
- caffeine
- ulauncher-toggle

### Customization & Aesthetics
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
<!-- last_hash:fb4b3168474ecb212996cc0ff40840110f954105 -->

Here are today's NixOS flake changes:

*   A routine automated backup of the NixOS flake configuration was executed.
*   The backup, identified by commit `acd3d66`, was timestamped at `2025-12-20T02:40:49Z`.
*   This activity by `ad-archer` ensures the current flake state is preserved as part of ongoing system maintenance.

Highlight: Automated flake configuration backup completed.


#### Part 2

Here's an update to your flake log summary:

- Automatic flake backup on 2025-12-20.


#### Part 3

- An automatic backup commit was recorded for `2025-12-20T02:50:50Z` by `ad-archer`.
- This commit primarily captures the current system state and introduces no new functional changes.
