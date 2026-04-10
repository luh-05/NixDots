{
  inputs,
  pkgs,
  lib,
  config,
  home,
  ...
}:
{
  # home.file.".config/niri".source = config.lib.file.mkOutOfStoreSymlink lib.path.subpath.join [ 
  #   /.
  #   "/hosts/laptop" 
  # ];
}
