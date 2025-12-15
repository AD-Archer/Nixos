{
  description = "Nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    illogical-impulse-dotfiles = {
      url = "github:xBLACKICEx/dots-hyprland?ref=tmp";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, ... }@inputs: {
    nixosConfigurations.hypr = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        nix-flatpak.nixosModules.nix-flatpak
        ./configuration.nix
        ./apps/package.nix
        ./apps/flatpaks.nix
        ./apps/gnome-extensions.nix
        ./apps/gnome-custom.nix
        ./apps/ollama.nix
        ./apps/firewall.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.root = import ./users/root/default.nix;
            users.arch = import ./users/arch/default.nix;
            extraSpecialArgs = { inherit inputs; };
            # Avoid clobbering existing *.backup files; use a unique suffix
            backupFileExtension = "hm-bak";
          };
        }
      ];
    };
  };
}
