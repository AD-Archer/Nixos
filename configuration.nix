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
  vimPlugins.nvchad
  zimfw

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
  programs.gpaste.enable = true;
  # Keep GNOME but drop its default terminal/browser
  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    gnome-terminal
    epiphany  # GNOME Web
  ];
  services.tailscale.enable = true; 
  services.flatpak.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Auto git backup of /etc/nixos after successful activation (e.g., nixos-rebuild switch)
  system.activationScripts.autoBackup = ''
    if [ -x /etc/nixos/scripts/auto-backup.sh ]; then
      # Run as arch so pushes use the user's creds/config
      /run/wrappers/bin/su -s ${pkgs.bash}/bin/bash arch -c /etc/nixos/scripts/auto-backup.sh
    fi
  '';
}
