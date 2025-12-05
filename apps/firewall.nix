{ config, lib, pkgs, ... }:

{
  # Enable NixOS default firewall
  networking.firewall.enable = true;

  # Allow SSH on port 22
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Trust the Tailscale interface to allow all traffic from tailnet
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # Enable OpenSSH for SSH access
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;  # Use keys only
    };
  };
}