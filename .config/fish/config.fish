function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)' #peco
  bind \c] 'peco_select_ghq_repository'  # ghq
end

alias g git
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias l ls\ -AFG
alias ll ls\ -AFGl
alias ip ifconfig

#for mac
alias pbc pbcopy
alias pbp pbpaste

#rbenv
status --is-interactive; and source (rbenv init -|psub)

# postgres data path
export PGDATA=/usr/local/var/postgres

# default editor
export EDITOR=vim

set -g fish_user_paths "/usr/local/opt/v8@3.15/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/imagemagick@6/bin" $fish_user_paths

# pow 
export POW_DOMAINS=test,dev
