{ pkgs, ... }:
{
  home.packages = with pkgs; [
    certbot
    curl
    jq
    nginx
    nmap
    wget

    ghostty-bin
    htop
    ncdu
    eza
    ranger
    zoxide
    glow

    helix
    imhex
    lldb
    lua-language-server
    nil

    gh
    jjui

    postgresql
    postgresqlPackages.timescaledb
    sqlx-cli

    bun
    nodejs_22
    go
    python3
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
    zig
    nixfmt

    openssl
    pkg-config
    buf
    protobuf
    typst

    direnv
    nix-direnv
    nushell

    ripgrep
    fd

    pnpm
    typescript
    typescript-language-server
    eslint
    npm-check-updates

    nerd-fonts.monaspace
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
  ];

  home.file."Library/Fonts/Nix/JetBrainsMono".source =
    "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono";

  home.file."Library/Application Support/com.mitchellh.ghostty/config".source = ../ghostty/config;
  home.file."Library/Application Support/com.mitchellh.ghostty/focused-split-frame.glsl".source =
    ../ghostty/focused-split-frame.glsl;

  xdg.configFile."helix".source = ../helix;
  xdg.configFile."jjui/config.toml".source = ../jjui/config.toml;

  programs.home-manager.enable = true;
}
