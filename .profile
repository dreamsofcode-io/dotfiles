alias c="clear"
alias vim='nvim'
alias ls='ls --color=auto'
alias k='kubectl'
alias h='helm'

export EDITOR="nvim"
export SHELL="zsh"

export GOPATH="$HOME/.go"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:/opt/android-sdk/platform-tools"
export PATH="$PATH:/opt/android-sdk/build-tools"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/sbin"
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

DO_POLLEN() {
  pass show tokens/digitalocean/pollen
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

alias gpg-unlock="gpg-connect-agent updatestartuptty /bye"

[ -s "/home/elliott/.svm/svm.sh" ] && source "/home/elliott/.svm/svm.sh"

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
alias protonmail-bridge='PASSWORD_STORE_DIR="$HOME/.local/share/pass" protonmail-bridge'

if [ -f /opt/asdf-vm/asdf.sh ]; then
  export ASDF_DIR=/opt/asdf-vm
  export ASDF_CONFIG_FILE=$HOME/asdf/asdfrc
  export ASDF_DATA_DIR=$HOME/asdf
  source $ASDF_DIR/asdf.sh

  # Insert autocompletion setup for your shell here.
fi
