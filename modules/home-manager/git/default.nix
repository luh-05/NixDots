{ inputs, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Luh-code";
    userEmail = "Lasse@hueffler.de";
    extraConfig = {
      safe = {
        directory = "*";
      };
      credential = {
        helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
      };
    };
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
  };
}
