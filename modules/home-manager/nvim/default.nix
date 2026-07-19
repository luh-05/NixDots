{
  inputs,
  pkgs,
  lib,
  config,
  hostName,
  cpaths,
  ...
}:
{
  home.packages = with pkgs; [
    neovim
    clang-tools
    cargo
  ];
  
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${cpaths.modules.home}/nvim/conf/"; 
}
