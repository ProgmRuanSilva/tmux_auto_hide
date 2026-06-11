#!/usr/bin/env bash

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/scripts" && pwd)"

# Register event hooks only once per server to prevent duplicates on reload
if [ -z "$(tmux show-option -gqv '@status_autohide_initialized')" ]; then
    tmux set-option -g @status_autohide_initialized "1"
    tmux set-hook -ga after-new-window "run-shell -b '$SCRIPTS_DIR/show_and_hide.sh'"
    tmux set-hook -ga window-unlinked  "run-shell -b '$SCRIPTS_DIR/show_and_hide.sh'"
fi

# Show briefly then hide (startup or manual toggle via key binding)
"$SCRIPTS_DIR/show_and_hide.sh" &
