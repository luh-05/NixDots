
{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.config.allowUnfree = true;
    #hosts.url = "./hosts/default";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.3-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    #home-manager-modules.url = "./modules/home-manager";
    #nixos-modules.url = "./modules/nixos";

    #nixvim = {
    #  url = "github:nix-community/nixvim";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    hyprcursor.url = "github:hyprwm/hyprcursor";
    hypridle.url = "github:hyprwm/hypridle";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-contrib.url = "github:hyprwm/contrib";
    hyprlock.url = "github:hyprwm/hyprlock";
    #hyprpaper.url = "github:hyprwm/hyprpaper";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #swww.url = "github:LGFae/swww";

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
        #aerial-nvim.follows = "plugin-aerial-nvim";
        #gitsigns-nvim.follows = "plugin-gitsigns-nvim";
      };
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = { self, nixpkgs, nvf, spicetify-nix, lix-module, ... }@inputs:
    let
     customNeovim = 
            nvf.lib.neovimConfiguration {
              pkgs = nixpkgs.legacyPackages."x86_64-linux";
              modules = [ ./modules/home-manager/nvf/main.nix ];
            };
      mkHost = hostName: system: extraModules:
        {
          #packages.${system}.default = 
          #  (nvf.lib.neovimConfiguration {
          #    pkgs = import nixpkgs {
          #      inherit system;
          #      config = {allowUnfree = true;};
          #    };
          #    modules = [ ./modules/home-manager/nvf/main.nix ];
          #  }).neovim;
	  #packages.${system}.my-neovim = customNvim.neovim;
        
          sys = nixpkgs.lib.nixosSystem {
            pkgs = import nixpkgs {
              inherit system;
              config = {
                 allowUnfree = true; 
              };
            };

            specialArgs = {
              inherit inputs;
            };
            modules =
              [
                lix-module.nixosModules.lixFromNixpkgs
                ./hosts/shared/configuration.nix
                ./hosts/${hostName}/configuration.nix
                #./hosts/${hostName}/home.nix
                inputs.stylix.nixosModules.stylix
                #nvf.nixosModules.default
                inputs.spicetify-nix.nixosModules.default
              ] ++ extraModules;
          };
        };
    in
    {

      
      #customNeovim = 
      #      nvf.lib.neovimConfiguration {
      #        pkgs = nixpkgs.legacyPackages."x86_64-linux";
      #        modules = [ ./modules/home-manager/nvf/main.nix ];
      #      };

      packages."x86_64-linux".my-neovim = customNeovim.neovim;

      nixosConfigurations = {
        default = (mkHost "default" "x86_64-linux" [
	        ./hosts/shared/gpus/nvidia.nix
          ./hosts/shared/cpus/amd.nix
          ./hosts/shared/kb-layouts/en_us.nix
          #./hosts/default/hyprland.nix
	  {environment.systemPackages = [customNeovim.neovim];}
        ]).sys;
        laptop = (mkHost "laptop" "x86_64-linux" [
	        ./hosts/shared/kb-layouts/en_us.nix
	        #./hosts/shared/gpus/nvidia.nix 
        ]).sys;
       };

      homeManagerConfigurations = {
        default = {
	  pkgs = nixpkgs.legacyPackages."x86_64-linux";

	  specialArgs = {
	    inherit inputs;
	  };

	  modules =
	    [
	      nvf.homeManagerModules.default
	    ];
        };
      };
    };
}
