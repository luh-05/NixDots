{ inputs, pkgs, lib, config, ... } :

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  options = {
    spicetify.enable = lib.mkEnableOption "Enable Spicetify";
  };

  config = lib.mkIf config.spicetify.enable {
    programs.spicetify = 
    {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        shuffle # shuffle+ (special characters are sanitized out of extension names)
        bookmark
        fullAppDisplay
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
          #ncsVisualizer
      ];
      enabledSnippets = with spicePkgs.snippets; [
        pointer
      ];

        #theme = spicePkgs.themes.catppuccin;
        #colorScheme = "mocha";
    };
  };
}
