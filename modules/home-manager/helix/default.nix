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
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        }
        {
          name = "zig";
          auto-format = true;
          # formatter.command = "zig";
          # formatter.args = ["fmt" "--stdin" "--stdin-filename %{buffer_name}"];
        }
        {
          name = "gts";
          auto-format = true;
          formatter.command = "${pkgs.prettier}/bin/prettier";
        }
      ];
      language-server = {
        zls = {
          command = "${pkgs.zls}/bin/zls";
          config.zls = {
            enable_build_on_save = true;
            build_on_save_args = ["check" "-fincremental" "--watch"];
            force_autofix = true;
            warn_style = true;
            highlight_global_var_declarations = true;
            
            zig_exe_path = "${pkgs.zig}/bin/zig";
          };
        };
      };
    };
  };
}
