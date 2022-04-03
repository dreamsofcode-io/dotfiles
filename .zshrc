# Load in SSH for the yubikey
# first load the GPG_TTY either from the TTY var (fast), or the tty command
# if $TTY is not set.
if [ -n "$TTY" ]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="$TTY"
fi

# Set the SSH_AUTH_SOCK via the gpg command
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="/usr/local/bin:/usr/bin"

source "${HOME}/.zgen/zgen.zsh"
source "${HOME}/.config/zgen.zsh"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
POWERLINE_ZSH_ROOT=""

source $HOME/.profile
source $HOME/.config/tmuxinator/tmuxinator.zsh

if [ Darwin = `uname` ]; then
  source $HOME/.profile-macOS
elif [ Linux = `uname` ]; then
  source $HOME/.profile-linux
fi

setopt auto_cd

#export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$PATH:/home/elliott/Library/flutter/bin"

alias sudo='sudo '
export LD_LIBRARY_PATH=/usr/local/lib

source <(doctl completion zsh)

source <(kubectl completion zsh)

#. $HOME/.asdf/asdf.sh
#. $HOME/.asdf/completions/asdf.bash

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/elliott/Projects/Modal/aws/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/elliott/Projects/Modal/aws/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/elliott/Projects/Modal/aws/node_modules/tabtab/.completions/sls.zsh ]] && . /home/elliott/Projects/Modal/aws/node_modules/tabtab/.completions/sls.zsh

# Fix for password store
export PASSWORD_STORE_GPG_OPTS='--no-throw-keyids'

export NVM_DIR="$HOME/.nvm"                            # You can change this if you want.
export NVM_SOURCE="/usr/share/nvm"                     # The AUR package installs it to here.
[ -s "$NVM_SOURCE/nvm.sh" ] && . "$NVM_SOURCE/nvm.sh"  # Load N

# Using rbenv
# eval "$(rbenv init -)"

#bindkey "^V" backward-char

#bindkey -v
#bindkey -v '^?' backward-delete-char
#bindkey "^R" history-incremental-search-backward
#bindkey "^N" down-line-or-search
#bindkey "^P" up-line-or-search
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

[ -s "/home/elliott/.svm/svm.sh" ] && source "/home/elliott/.svm/svm.sh"

