alias zshconfig="nvim ${ZDOTDIR}/.zshrc"
alias pretzoconfig="nvim ${ZDOTDIR}/.preztorc"
alias tmuxa="tmux new-session -A"
alias tmuxl="tmux list-sessions"
alias cl="clear"
alias e="exit"
alias ..="cd .."
alias format="ktlint -F"
alias go-deps="go get -u ./..."
alias k="kubectl"
alias hs="history 0 | grep"
alias hsi="history 0 | grep -i"
alias uuid="uuidgen | awk '{print tolower($1)}'"
alias ll="eza -albgo"
alias v="vim"
alias fv="fvim"
alias ssh="TERM=screen-256color ssh"
alias merge="gh pr merge -m -d"
alias squash="gh pr merge -s -d"
