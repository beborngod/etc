{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    mouse = true;
    keyMode = "vi";
    shell = "${pkgs.fish}/bin/fish";

    plugins = [
      pkgs.tmuxPlugins.nord
    ];

    extraConfig = ''
      #set -g default-shell /bin/zsh
      #set -g default-command "/bin/zsh -l"

      # pane nav
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # prefix
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix
      
      # bar on top + truecolor
      set -g status-position top
      set -ag terminal-overrides ",*:RGB"
      set -g status-right ""
      
      # reload
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display "reloaded"
    '';
  };
}
