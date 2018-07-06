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
