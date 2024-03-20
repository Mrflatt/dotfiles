. "$HOME/.cargo/env"
export EDITOR="nvim"
export KUBE_EDITOR="$EDITOR"
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export SDKMAN_DIR="$HOME/.sdkman"
export NVM_DIR="$HOME/.nvm"
export PATH="/usr/local/opt/openssl@3/bin:$PATH:/usr/local/sbin:${GOROOT}/bin:${GOPATH}/bin:${JAVA_HOME}/bin"

if type brew &>/dev/null; then
	FPATH="${FPATH}:$(brew --prefix)/share/zsh/site-functions"
	autoload -Uz compinit
	compinit
	export GOROOT="$(brew --prefix golang)/libexec"
else
	export GOROOT="/usr/local/go"
fi
