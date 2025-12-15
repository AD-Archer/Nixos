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

- Firewall enabled (NixOS)
- Allow TCP: 22, 42000
- Allow UDP ranges: UDP 1714-1764
- Trusted interfaces: tailscale0
- SSH PermitRootLogin: no
- SSH password auth: false

## System Packages

- wget
- kitty
- gcc
- fastfetch
- gpaste
- ulauncher
- pokemon-colorscripts
- fzf
- bitwarden-desktop
- Terminal
- tools
- tmux
- curl
- btop
- bat
- lazygit
- vimPlugins.nvchad
- zimfw
- gemini-cli
- Dev
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

## Flatpaks

- app.zen_browser.zen
- dev.vencord.Vesktop
- org.kde.filelight
- org.vinegarhq.Sober
- com.usebottles.bottles
- com.github.tchx84.Flatseal
- org.gimp.GIMP
- us.zoom.Zoom
- io.gitlab.adhami3310.Impression
- io.mrarm.mcpelauncher
- com.mojang.Minecraft
- org.gnome.Extensions
- com.slack.Slack
- io.github.pwr_solaar.solaar
- org.x.Warpinator
- io.github.giantpinkrobots.flatsweep
- io.github.realmazharhussain.GdmSettings
- org.gnome.Todo
- com.pokemmo.PokeMMO
- io.github.mhogomchungu.media-downloader
- com.atlauncher.ATLauncher
- io.github.qwersyk.Newelle
- io.github.Foldex.AdwSteamGtk
- com.obsproject.Studio
- Session
- Bus
- Policy.org.freedesktop.Flatpak
- talk;
- };
- };
- services.flatpak.uninstallUnmanaged
- true;
- Removes
- undeclared
- apps
- on
- rebuild
- }

## GNOME Extensions

- Essential
- extensions
- (verified
- names)
- appindicator
- clipboard-indicator
- gsconnect
- sound-output-device-chooser
- Popular
- productivity
- caffeine
- ulauncher-toggle
- Working
- alternatives
- quick-settings-tweaker
- just-perfection
- blur-my-shell

## Ollama Models
- qwen2.5-coder:3b
- hf.co/mradermacher/Dolphin3.0-Qwen2.5-0.5B-GGUF:Q8_0
- hf.co/Qwen/Qwen2.5-Coder-1.5B-Instruct-GGUF:Q4_K_M
- mxbai-embed-large:latest

## Daily Changes



### 2025-12-11
<!-- last_hash:88d7631f4092473114f0fb5e3a76a947d46330cc -->

Here are today's NixOS flake changes:

*   Daily updates for the NixOS flake have been logged.
*   An automated backup of the flake configuration was performed.
*   The backup snapshot corresponds to 2025-12-11 at 18:08:54Z UTC.
*   This automatic backup commit was initiated by 'ad-archer'.

Highlight: Daily NixOS flake auto-backup completed.











### 2025-12-06
<!-- last_hash:3a2be03a4b243a555b1b1e1ee60e3f484451ed93 -->

Here are today's NixOS flake changes for 2025-12-06:

*   Performed an automatic backup of the NixOS flake configuration.
*   The backup was committed under hash `77c97e4` at 19:09:50Z.
*   This routine operation, initiated by `ad-archer`, ensures the latest flake state is preserved.

Highlight: Daily flake configuration backup completed.

































#### Part 16

Here's the update for your NixOS flake log:

*   Performed a routine automatic flake backup.


#### Part 17

Here are the additional changes:

*   Automated flake backup.


#### Part 18

Here's an update for your NixOS flake log:

*   Performed an automatic flake backup.


#### Part 19

Here's an update for today's NixOS flake log:

*   Automated flake backup.


#### Part 20

Here's an update for your NixOS flake log:

*   Performed an automatic backup of the flake configuration.
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


#### Part 10

Here are the additional changes for today's NixOS flake log:

*   Switched to the NixOS default firewall, renaming `ufw.nix` to `firewall.nix`.
*   Ensured the backup service has `bash` and `git` available in its PATH.
*   Included several manual updates and general configuration adjustments throughout the day.


#### Part 11

Here's a summary of the additional changes for today's NixOS flake log:

*   Switched to the NixOS default firewall implementation and renamed the configuration file from `ufw.nix` to `firewall.nix`.
*   Ensured the backup service has necessary executables (`bash`, `git`) available in its PATH.


#### Part 12

Here's a summary of the additional changes for today's log:

*   Switched to the NixOS default firewall, accompanied by a rename of the configuration file from `ufw.nix` to `firewall.nix`.
*   Improved the backup service by ensuring `bash` and `git` are correctly included in its PATH.
*   Numerous automated backups and timestamped saves reflect continuous development and progress throughout the day.


#### Part 13

Here are the additional changes for today's NixOS flake log:

*   Switched to the NixOS default firewall, refactoring the configuration file from `ufw.nix` to `firewall.nix`.
*   Improved the reliability of the backup service by explicitly ensuring `bash` and `git` are available in its PATH.
*   Recorded numerous automated backups and several manual checkpoints throughout the day.


#### Part 14

Here's a brief summary of the changes for today's NixOS flake log:

*   Switched to the NixOS default firewall, renaming `ufw.nix` to `firewall.nix`.
*   Ensured the backup service has `bash` and `git` in its PATH for proper operation.
*   Numerous automatic and manual backup checkpoints were recorded throughout the day.


#### Part 15

Here are the additional changes for today's NixOS flake log:

*   Switched to the NixOS default firewall, renaming `ufw.nix` to `firewall.nix`.
*   Ensured the backup service has `bash` and `git` in its `PATH`.
*   Numerous automatic backups reflect continuous development throughout the day.
