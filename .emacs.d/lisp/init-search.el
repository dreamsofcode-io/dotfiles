;; init-search.el

(use-package rg
  :config
  (rg-enable-default-bindings))

(use-package projectile-ripgrep
  :after projectile)

(provide 'init-search)
