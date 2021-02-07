;; init-key.el

;(use-package general
  ;:config
  ;(general-create-definer my-leader-def
    ;:states '(normal insert visual emacs)
    ;:keymaps 'override
    ;:prefix "SPC"
    ;:global-prefix "M-SPC")

  ;(general-create-definer my-leader-def-local
    ;:states '(normal insert visual emacs)
    ;:keymaps 'override
    ;:major-modes t
    ;:prefix ","
    ;:non-normal-prefix "C-,")

  ;(my-leader-def
    ;"t"  '(:ignore t :which-key "toggles")
    ;"tt" '(load-theme :which-key "choose theme")
    ;"tw" 'whitespace-mode
    ;"tm" 'toggle-frame-maximized
    ;"tM" 'toggle-frame-fullscreen
    ;"p"  '(:ignore p :which-key "projectile")
    ;"pa" 'projectile-add-known-project
	;"pc" 'projectile-compile-project
    ;"pf" 'projectile-find-file
    ;"pp" 'projectile-switch-project
    ;"p/" 'projectile-ripgrep))

;(global-set-key (kbd "C-M-j") #'switch-to-buffer)
;(global-set-key (kbd "M-:") 'pp-eval-expression)

(provide 'init-key)
