{ inputs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh --cmd cd)"
      eval "$(sh /home/luh/.dots/tmux.sh)"
      LS_COLORS=$LS_COLORS:'tw=32' ; export LS_COLORS
      LS_COLORS=$LS_COLORS:'ow=34' ; export LS_COLORS
    '';

    # set shell aliases
    shellAliases = {
      update = "sudo NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild switch --no-reexec --impure";
      la = "eza -lA";
      # kimg = "/home/luh/.dots/modules/home-manager/zsh/kimg.sh";
    };

    # set up oh-my-zsh
    oh-my-zsh = {
      enable = false;
      plugins = [
        "git"
        "pay-respects"
      ];
      theme = "af-magic";
    };

    # set up zsh-autosuggestions
    autosuggestion = {
      enable = true;
    };

    # set up ssyntaxHighlighting
    syntaxHighlighting = {
      enable = true;
    };
  };
}
