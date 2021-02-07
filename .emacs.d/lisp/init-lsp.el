;; init-lsp.el

(use-package lsp-mode
  :hook ((go-mode . lsp))
  :custom
  (lsp-enable-file-watchers nil)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-keymap-prefix "s-l")
  (lsp-enable-indentation nil)
  :config
  (lsp-enable-which-key-integration t))

(provide 'init-lsp)
