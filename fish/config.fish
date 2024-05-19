# mise-en-place
/home/robbin/.local/bin/mise activate fish | source

# brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# bun
set -x BUN_INSTALL "$HOME/.bun"
#set -x PATH $BUN_INSTALL/bin $PATH

# global variables
set -Ux EDITOR (which nvim)
set -ga XDG_DATA_DIRS $HOME/.nix-profile/share


# Abbreviations
## Navigation
abbr -a -- cc cd\ \(find\ \~/\ -type\ d\ -regex\ \'^\[^\\.\]+\$\'\ \|\ fzf\)
abbr -a -- p cd\ \(find\ \~/projects\ -maxdepth\ 2\ -type\ d\ -regex\ \'^\[^\\.\]+\$\'\ \|\ fzf\)
abbr -a -- cf 'cd (find ~/.config -maxdepth 1 -type d | fzf) && nvim'

## Git
abbr -a -- ga 'git add'
abbr -a -- gc 'git commit'
abbr -a -- gcam 'git commit -am'
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
abbr -a -- a 'wl-paste >'
abbr -a -- yt 'youtube-dl -x --audio-format mp3'
abbr -a -- mixwatch inotifywait\ -rmq\ --include\ \'\\.\(exs\?\|lua\)\$\'\ -e\ modify\ .\ \|\ mix\ test\ --stale\ --listen-on-stdin

# opam configuration
source /home/robbin/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
