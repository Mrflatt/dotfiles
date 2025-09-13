[[ -f "$ZDOTDIR/.p10k.zsh" ]] && source "$ZDOTDIR/.p10k.zsh"
[[ -f "$ZDOTDIR/export.sh" ]] && source "$ZDOTDIR/export.sh"
[[ -f "$ZDOTDIR/export.local.sh" ]] && source "$ZDOTDIR/export.local.sh"

# Load custom functions and completions
if [[ -d "$ZDOTDIR/functions" ]]; then
  fpath=($ZDOTDIR/functions $fpath)
  autoload -Uz $(ls $ZDOTDIR/functions)
fi

if [[ -d "$ZDOTDIR/completions" ]]; then
  fpath=($ZDOTDIR/completions $fpath)
  cmds=(netconf gofka kubectl)
  for cmd in $cmds; do
    if (( $+commands[$cmd] )); then
      $cmd completion zsh >! $ZDOTDIR/completions/_$cmd
    fi
  done
fi

if (( $+commands[brew] )); then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Load aliases last so zprezto aliases can be overridden
[[ -f "$ZDOTDIR/aliases.sh" ]] && source "$ZDOTDIR/aliases.sh"
[[ -f "$ZDOTDIR/aliases.local.sh" ]] && source "$ZDOTDIR/aliases.local.sh"
eval "$(zoxide init zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

. "$HOME/.local/share/../bin/env"

# pnpm
export PNPM_HOME="/Users/lauri/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
