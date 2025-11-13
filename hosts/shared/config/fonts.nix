{
  config,
  lib,
  pkgs,
  options,
  inputs,
  cpaths,
  ...
}:

let

in
{
  fonts.packages = with pkgs; [
    (pkgs.callPackage "${cpaths.modules.fonts}/feather-font.nix" { })
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];
}
