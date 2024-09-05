{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g status-bg cyan
      set -g window-status-style bg=red
      set -g window-status-current-style bg=yellow
      set -g status-right-length 60
      set-option -sg status-interval 2
      set -g mouse on

      # Window options to move around similar to a vim style
      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D

      # Allowing for vim keybinds in tmux for copying
      set-window-option -g mode-keys vi
      bind P paste-buffer
      bind-key -T copy-mode-vi v send -X begin-selection
      bind-key -T copy-mode-vi y send -X copy-selection
      bind-key -T copy-mode-vi r send -X rectangle-toggle
    '';
  };
}
