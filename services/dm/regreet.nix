{
  inputs,
  config,
  options,
  lib,
  pkgs,
  ...
}:
{
  programs.regreet = {
    enable = true;
    # font = {
    #   package = pkgs.nerd-fonts.fira-mono;
    #   name = "FiraMono Nerd Font";
    # };
    extraCss = "
    window {
      background-color: #0d0d0d;
    }
    ";
  };

  # services.cage.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      terminal = {
        vt = 1;
      };
      # default_session = {
      #   command = "dbus-run-session cage -s -mlast -- regreet";
      #   user = "greeter";
      # };
    };
  };
}
