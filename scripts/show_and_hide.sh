#!/usr/bin/env bash

# Use the tmux server's PID (from $TMUX env var) to scope the PID file
# $TMUX format: "<socket_path>,<server_pid>,<session_id>"
SERVER_PID=$(echo "$TMUX" | cut -d',' -f2)
PID_FILE="/tmp/tmux_autohide_${SERVER_PID}.pid"

# Cancel any previous pending hide timer
if [ -f "$PID_FILE" ]; then
    old_pid=$(cat "$PID_FILE")
    kill "$old_pid" 2>/dev/null
fi

echo $$ > "$PID_FILE"

status_delay=$(tmux show-option -gqv "@status_autohide_delay")
status_delay=${status_delay:-3}

multi_window=$(tmux show-option -gqv "@status_autohide_multi_window")
multi_window=${multi_window:-on}

tmux set-option -g status on

# When multi-window mode is enabled and more than one window exists, keep the
# status bar on and don't schedule a hide.
if [ "$multi_window" = "on" ]; then
    window_count=$(tmux list-windows | wc -l)
    if [ "$window_count" -gt 1 ]; then
        rm -f "$PID_FILE"
        exit 0
    fi
fi

sleep "$status_delay"
tmux set-option -g status off

rm -f "$PID_FILE"
