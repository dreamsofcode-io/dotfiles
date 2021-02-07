;; init-dev.el

(column-number-mode)

;; Enable line numbers for prog modes only
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)
	    (display-fill-column-indicator-mode 1)))

(setq-default fill-column 80)
(setq-default tab-width 4)
(setq-default evil-shift-width tab-width)

(use-package paren
  :hook (prog-mode . show-paren-mode))

(use-package rainbow-mode
  :commands rainbow-mode)

(provide 'init-dev)

