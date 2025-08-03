{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        soft-wrap.enable = true;
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }
    {
      name = "zig";
      auto-format = true;
      formatter.command = "${pkgs.zig}/bin/zig fmt";
    }];
  };
}
