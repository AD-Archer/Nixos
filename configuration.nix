{ config, lib, pkgs, ...}:

{
 imports = 
  [
  ./hardware-configuration.nix
  ]; 


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hypr";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  services.getty.autologinUser = "arch";
  
  programs.hyprland = {
  enable=false;
  xwayland.enable = true;
  withUWSM = true; 
 };


  users.users.arch = {
  isNormalUser = true;
  extraGroups = [ "wheel" ];
  shell = pkgs.zsh;
  packages = with pkgs; [
       tree
     ];
    };
  users.users.root.shell = pkgs.zsh;

  
  # Packages
  programs.zoxide.enable = true;
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
  vim
  wget
  kitty
  gcc
  nodejs
  pnpm
  fastfetch
  vscode
  gpaste
  ulauncher
  pokemon-colorscripts
  gemini-cli

  # Terminal
  tmux
  neovim
  git
  curl
  btop
  bat
  lazygit

  #node stuff
  codex
  nodePackages.vercel
  ];

programs.zoxide.enableZshIntegration = true;
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};


  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.11";

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  # Keep GNOME but drop its default terminal/browser
  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    gnome-terminal
    epiphany  # GNOME Web
  ];
  services.tailscale.enable = true; 
  services.flatpak.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Auto git backup of /etc/nixos every 10 minutes
  systemd.services.nixos-auto-backup = {
    description = "Auto backup /etc/nixos to git";
    serviceConfig = {
      Type = "oneshot";
      User = "arch"; # use user's SSH key/remote config
      WorkingDirectory = "/etc/nixos";
      ExecStart = "/etc/nixos/scripts/auto-backup.sh";
    };
  };

  systemd.timers.nixos-auto-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "10min";
      Unit = "nixos-auto-backup.service";
    };
  };
}
