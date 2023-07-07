{ config, pkgs, ... }:

let
  gui-essentials = with pkgs; [
    alacritty
    spotify
    thunderbird
    vlc
    libreoffice-fresh
    discord
    ark
    keepassxc
    nextcloud-client
  ];

  gui-extras = with pkgs; [
    picard
    k3b
    libreoffice-fresh
  ];

  video-editing = with pkgs; [
    obs-studio
    kdenlive
    mediainfo
  ];

  terminal-apps = with pkgs; [
    duf
    bat
    exa
    tealdeer
    fd
    gping
    gh
    htop
  ];

  nix-utils = with pkgs; [
    nixpkgs-fmt
    nil
    any-nix-shell
    nix-index
  ];

in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "f";
  home.homeDirectory = "/home/f";

  nixpkgs.config.allowUnfree = true;
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;

    shellInit = "
    set fish_greeting;
    any-nix-shell fish --info-right | source";

    shellAliases = {
      gs = "git status";
      cat = "bat";
      ls = "exa";
      g = "git status --short";
    };
  };

  programs.starship = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      matklad.rust-analyzer
      redhat.vscode-yaml
      tamasfe.even-better-toml
      serayuzgur.crates
      asciidoctor.asciidoctor-vscode
      mkhl.direnv
    ];
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "onedark";
    };
  };

  programs.git = {
    enable = true;
    userName = "TuftedDeer";
    userEmail = "36223345+tufteddeer@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
    difftastic = {
      enable = true;
      background = "dark";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };


  home.packages = with pkgs;
    (
      #gui-essentials ++
      terminal-apps ++
      nix-utils
    );

}
