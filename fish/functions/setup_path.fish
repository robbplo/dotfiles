function setup_path
    set -U fish_user_paths /usr/local/bin /usr/sbin $HOME/.composer/vendor/bin (yarn global bin)
end
