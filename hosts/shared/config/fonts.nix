{
  config,
  lib,
  pkgs,
  options,
  inputs,
  ...
}:

let

in
{
  fonts.packages = with pkgs; [
    (pkgs.callPackage "${hmmp}/fonts/feather-font.nix" { })
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];
}
