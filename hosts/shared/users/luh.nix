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
  users.users.luh = {
    isNormalUser = true;
    description = "Lasse Ulf Hüffler";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "kvm"
    ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      vscode
      floorp-bin
      qemu
      quickemu
      virglrenderer
      spice
      dnsmasq
      phodav
    ];
  };
}
