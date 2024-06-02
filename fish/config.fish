### Run that shit
/home/robbin/.local/bin/mise activate fish | source
/home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source
source < /home/robbin/.opam/opam-init/init.fish

# Abbreviations
## Navigation
abbr -a -- cc cd\ \(find\ \~/\ -type\ d\ -regex\ \'^\[^\\.\]+\$\'\ \|\ fzf\)
abbr -a -- cf 'cd (find ~/.config -maxdepth 1 -type d | fzf) && nvim'

## Git
abbr -a -- ga 'git add'
abbr -a -- gc 'git commit'
abbr -a -- gcm 'git commit -m'
abbr -a -- gcam 'git commit -am'
abbr -a -- gcmm 'git commit --amend'
abbr -a -- gcamm 'git commit -a --amend'
abbr -a -- gco 'git checkout'
abbr -a -- gcp 'git cherry-pick'
abbr -a -- gm 'git merge'
abbr -a -- nah 'git reset --hard'
abbr -a -- mr 'glab mr view -w'
abbr -a -- pr 'gh pr checkout'

## Programs
abbr -a -- sail 'bash vendor/bin/sail'
abbr -a -- art 'bash vendor/bin/sail artisan'
abbr -a -- doco docker-compose
abbr -a -- vim nvim

## Utility
abbr -a -- p 'wl-paste'
abbr -a -- c 'wl-copy'
abbr -a -- yt 'youtube-dl -x --audio-format mp3'
abbr -a -- mixwatch inotifywait\ -rmq\ --include\ \'\\.\(exs\?\|lua\)\$\'\ -e\ modify\ .\ \|\ mix\ test\ --stale\ --listen-on-stdin

set --export BUN_INSTALL "$HOME/.bun"
