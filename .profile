alias c="clear"
alias vim='nvim'
alias ls='ls --color=auto'
alias k='kubectl'
alias h='helm'
alias vidaru-git='git config --local user.email "vidaru@protonmail.com"; git config --local user.name "vidaru"'
alias valar-git='git config --local user.email "elliott@valar.io"; git config --local user.name "Elliott Minns"'
alias elliott-git='git config --local user.email "elliott.minns@me.com"; git config --local user.name "Elliott Minns"'

export EDITOR="nvim"
export SHELL="zsh"

export GOPATH="$HOME/.go"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:/opt/android-sdk/platform-tools"
export PATH="$PATH:/opt/android-sdk/build-tools"
export PATH="$PATH:$HOME/.local/bin"
export KUBECONFIG="$HOME/.kube/config"

DO_VALAR() {
  pass show tokens/digitalocean/valar
}

DO_NANOTIFY() {
  pass show tokens/digitalocean/nanotify
}

DO_RAILPAY() {
  pass show tokens/digitalocean/railpay
}

docker_rm_stopped() {
  docker rm $(docker ps -a -q)
}

if which jenv > /dev/null; then eval "$(jenv init -)"; fi

if ! type open > /dev/null ; then
  alias open=xdg-open
fi

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

[ -s "/home/elliott/.svm/svm.sh" ] && source "/home/elliott/.svm/svm.sh"

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
alias protonmail-bridge='PASSWORD_STORE_DIR="$HOME/.local/share/pass" protonmail-bridge'

