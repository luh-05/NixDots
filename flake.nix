{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.3-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprcursor.url = "github:hyprwm/hyprcursor";
    hypridle.url = "github:hyprwm/hypridle";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-contrib.url = "github:hyprwm/contrib";
    hyprlock.url = "github:hyprwm/hyprlock";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugin-aerial-nvim = {
      url = "github:stevearc/aerial.nvim";
      flake = false;
    };

    plugin-gitsigns-nvim = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };

    plugin-which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };

    nvf = {
      url = "github:notashelf/nvf?rev=18bf52e540c745deb2c50fe3967cbe229a70bfe4";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    zen-browser = {
      url = "github:luh-05/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nvf,
      spicetify-nix,
      lix-module,
      zen-browser,
      ...
    }@inputs:
    let
      customNeovim = nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./modules/home-manager/nvf/main.nix ];
      };

      cpaths = {
        root = "/home/luh/.dots";
        services = "${cpaths.root}/services";
        modules = {
          root = "${cpaths.root}/modules";
          home = "${cpaths.modules.root}/home-manager";
          nixos = "${cpaths.modules.root}/nixos";
        };
      };

      mkHost = hostName: system: extraModules: {
        sys = nixpkgs.lib.nixosSystem {
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              permittedInsecurePackages = [
                "gradle-7.6.6"
              ];
            };
          };

          specialArgs = {
            inherit inputs;
            inherit cpaths;
          };
          modules = [
            lix-module.nixosModules.lixFromNixpkgs
            ./hosts/shared/configuration.nix
            ./hosts/${hostName}/configuration.nix
            inputs.stylix.nixosModules.stylix
            inputs.spicetify-nix.nixosModules.default
          ]
          ++ extraModules;
        };
      };
    in
    {
      packages."x86_64-linux".my-neovim = customNeovim.neovim;

      nixosConfigurations = {
        default =
          (mkHost "default" "x86_64-linux" [
            ./hosts/shared/gpus/nvidia.nix
            ./hosts/shared/cpus/amd.nix
            ./hosts/shared/kb-layouts/en_us.nix
            { environment.systemPackages = [ customNeovim.neovim ]; }
          ]).sys;
        laptop =
          (mkHost "laptop" "x86_64-linux" [
            ./hosts/shared/kb-layouts/en_us.nix
          ]).sys;
      };

      homeManagerConfigurations = {
        default = {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";

          specialArgs = {
            inherit inputs;
          };

          modules = [
            nvf.homeManagerModules.default
          ];
        };
      };
    };
}
