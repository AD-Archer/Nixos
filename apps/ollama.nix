{ config, pkgs, ... }:

{
  services.ollama = {
    enable = true;
    acceleration = "vulkan";
    host = "0.0.0.0";
    openFirewall = true;

  };
}
