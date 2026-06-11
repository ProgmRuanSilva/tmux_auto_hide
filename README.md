# Auto hide tmux status bar

![](./docs/presentation.gif)

Plugin that hides the tmux status bar after a few seconds and briefly shows it again when relevant events occur (e.g. a new window is created or a window is closed).

Installing
----------
Add plugin to the list of TPM plugins in `.tmux.conf`:

``` tmux
set -g @plugin 'progmruansilva/tmux_status_autohide'
```

Configure
---------
The plugin waits 3 seconds before hiding the status bar. To change the delay, add the *@status_autohide_delay* option before the plugin entry:

``` tmux
set -g @status_autohide_delay "2"
set -g @plugin 'progmruansilva/tmux_status_autohide'
```

When more than one window is open the status bar stays visible continuously. To disable this behaviour and always autohide regardless of window count, set *@status_autohide_multi_window* to `off`:

``` tmux
set -g @status_autohide_multi_window "off"
set -g @plugin 'progmruansilva/tmux_status_autohide'
```

Events
------
The status bar is shown briefly (for the configured delay) on the following events:

- Tmux startup
- A new window is created (`after-new-window`)
- A window is closed/removed (`window-unlinked`)

Other
-----
To toggle the status bar on for a while, bind a key to the show-and-hide script:

``` tmux
bind-key t run-shell "~/.tmux/plugins/tmux_status_autohide/scripts/show_and_hide.sh"
```

To disable / hide the status bar immediately on startup, add this plugin last with zero delay:

``` tmux
set -g @status_autohide_delay "0"
set -g @plugin 'progmruansilva/tmux_status_autohide'
```

### Thanks
Special thanks to [kallistoteles](https://github.com/kallistoteles/tmux_status_autohide) for the original idea.
