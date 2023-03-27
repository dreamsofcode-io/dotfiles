if ! zgen saved; then

  zgen oh-my-zsh

  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/pass
  zgen oh-my-zsh plugins/aws
  zgen oh-my-zsh plugins/kubectl
  zgen oh-my-zsh plugins/rust
  zgen oh-my-zsh plugins/command-not-found
  zgen load zsh-users/zsh-completions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions
  zgen load romkatv/powerlevel10k powerlevel10k

  # generate the init script from plugins above
  zgen save
fi
