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
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, ... }: {
    nixosConfigurations.hypr = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nix-flatpak.nixosModules.nix-flatpak
        ./configuration.nix
        ./apps/flatpaks.nix
        ./apps/gnome-extensions.nix
        ./apps/gnome-custom.nix
        ./apps/ollama.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.root = import ./users/root/default.nix;
            users.arch = import ./users/arch/default.nix;
            # Avoid clobbering existing *.backup files; use a unique suffix
            backupFileExtension = "hm-bak";
          };
        }
      ];
    };
  };
}
