#+TITLE: dotfiles

This repo contains my dotfile configuration, allowing for a consistent computing experience across multiple machines.
These days I primarily use GNU/Linux via the [[https://archlinux.org][Arch Linux distribution]].

I manage the various configuration files in this repo using [[https://www.gnu.org/software/stow/][GNU Stow]].  This allows me to set up symlinks for all of my dotfiles using a single command:

#+begin_src sh
stow .
#+end_src

* Inspiration

The inspiration for this configuration comes from the [[https://github.com/daviwil/dotfiles][dotfiles by daviwil]]. If you're looking for inspiration to create your own emacs configuration, or improve your system configuration synchronisation, then I'd suggest watching his videos.
