Reload
`tmux source ~/.tmux.conf`


## Plugin
---
[Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

Key bindings

Installs new plugins from GitHub or any other git repository && Refreshes TMUX environment
`prefix + I`

Updates plugin(s)
`prefix + U`

Remove/uninstall plugins not on the plugin list
`prefix + alt + u`



---
[Tmux Resurrect](https://github.com/tmux-plugins/tmux-resurrect)

Add plugin to the list of TPM plugins in ".tmux.conf":
`set -g @plugin 'tmux-plugins/tmux-resurrect'`


Key bindings
- `prefix + Ctrl-s` - save
- `prefix + Ctrl-r` - restore
