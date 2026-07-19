{ config, lib, ... }:
let
  modules = [
    "spicetify"
    "tmux"
  ];
in
{
  imports = map (x: ./${x}/default.nix) modules;
}
