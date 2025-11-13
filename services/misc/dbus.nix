{
  inputs,
  config,
  options,
  ...
}:
let

in
{
  services.dbus.enable = true;
}
