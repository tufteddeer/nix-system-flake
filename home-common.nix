{ config, pkgs, ... }:

{

  programs.starship = {
    enable = true;
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "onedark";
      editor = {
        soft-wrap = { enable = true; };
        statusline = {
          right = [
            "version-control"
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
          ];
        };
        lsp = { display-inlay-hints = true; };
      };

    };
  };

  programs.git = {
    enable = true;
    userName = "TuftedDeer";
    userEmail = "36223345+tufteddeer@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      gpg.format = "ssh";
    };
    difftastic = {
      enable = true;
      background = "dark";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    #enableZshIntegration = true;
    icons = "auto";
    git = true;
  };

  home.sessionVariables = { EDITOR = "hx"; };

  home.packages = with pkgs; [
    ripgrep
    doggo
    lazygit
    lazydocker
    tealdeer
    wget
    bat

    nix-index
    nixfmt
  ];

  programs.home-manager.enable = true;
}
