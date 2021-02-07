;; Variable for font sizing
(defvar kraken/default-font-size 100)
(defvar kraken/default-variable-font-size 120)

;; Make frame transparency overridable
(defvar kraken/frame-transparency '(90 . 90))

;; Bootstrap straight.el
(setq straight-use-package-by-default t
  straight-build-dir (format "build-%s" emacs-version))

(defvar bootstrap-version)
(let ((bootstrap-file
      (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(push "~/.emacs.d/lisp" load-path)

(server-start)

(setq kraken/exwm-enabled (and (eq window-system 'x)
                           (seq-contains command-line-args "--use-exwm")))

(when kraken/exwm-enabled
  (require 'kraken-desktop))

(setq inhibit-startup-message t)

(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode -1)   ; Disable the toolbar
(tooltip-mode -1)    ; Disable tooltips
(set-fringe-mode 10) ; Give some breating room

(menu-bar-mode -1)   ; Diable the menu bar

(toggle-frame-maximized) ; Start maximized

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))
	
(setq org-confirm-babel-evaluate nil)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-set-key (kbd "C-M-u") 'universal-argument)

(global-set-key (kbd "C-x C-b") #'ibuffer)

(defun kraken/evil-hook ()
  (dolist (mode '(custom-mode
                  eshell-mode
                  git-rebase-mode
                  erc-mode
                  circe-server-mode
                  circe-chat-mode
                  circe-query-mode
                  sauron-mode
                  term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

(defun kraken/dont-arrow-me-bro ()
  (interactive)
  (message "Arrow keys are bad, you know?"))

(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-tree)
  :config
  (add-hook 'evil-mode-hook 'kraken/evil-hook)
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ;; Disable arrow keys in normal and visual modes
  (define-key evil-normal-state-map (kbd "<left>") 'kraken/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<right>") 'kraken/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<down>") 'kraken/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<up>") 'kraken/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<left>") 'kraken/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<right>") 'kraken/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<down>") 'kraken/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<up>") 'kraken/dont-arrow-me-bro)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :custom
  (evil-collection-outline-bind-tab-p nil)
  :config
  (evil-collection-init))

(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer kraken/leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general-create-definer kraken/ctrl-c-keys
    :prefix "C-c"))

(use-package blackout
  :straight (:host github :repo "raxod502/blackout"))

(use-package which-key
  :blackout t
  :hook (after-init . which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5))

(use-package doom-themes
  :init (load-theme 'doom-nord t))

(set-face-attribute 'default nil
  :font "MonoLisa" 
  :height kraken/default-font-size 
  :weight 'medium)

(set-face-attribute 'fixed-pitch nil 
  :font "MonoLisa" 
  :height kraken/default-font-size)

(set-face-attribute 'variable-pitch nil 
  :font "Cantarell"
  :height kraken/default-variable-font-size
  :weight 'regular)

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package alert
  :commands alert
  :config
  (setq alert-default-style 'notifications))

(kraken/leader-key-def
  "t"  '(:ignore t :which-key "toggles")
  "tt" '(load-theme :which-key "choose theme")
  "tw" 'whitespace-mode
  "tm" 'toggle-frame-maximized
  "tM" 'toggle-frame-fullscreen)

(setq epa-pinentry-mode 'loopback)
(use-package pinentry
  :init (pinentry-start))

(setq-default tab-width 2)
(setq-default evil-shift-width tab-width)

(setq-default indent-tabs-mode nil)

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package ws-butler
  :hook ((text-mode . ws-butler-mode)
         (prog-mode . ws-butler-mode)))

(use-package parinfer
  :hook ((clojure-mode . parinfer-mode)
         (emacs-lisp-mode . parinfer-mode)
         (common-lisp-mode . parinfer-mode)
         (scheme-mode . parinfer-mode)
         (lisp-mode . parinfer-mode))
  :config
  (setq parinfer-extensions
      '(defaults       ; should be included.
        pretty-parens  ; different paren styles for different modes.
        evil           ; If you use Evil.
        smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
        smart-yank)))  ; Yank behavior depend on mode.

(kraken/leader-key-def
  "tp" 'parinfer-toggle-mode)

(use-package origami
  :hook (yaml-mode . origami-mode))

;; TODO: Mode this to another section
(setq-default fill-column 80)

;; Turn on indentation and auto-fill mode for Org files
(defun kraken/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil)
  (blackout org-indent-mode))

(use-package org
  :defer t
  :hook (org-mode . kraken/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 2
        org-hide-block-startup nil
        org-src-preserve-indentation nil
        org-startup-folded 'content
        org-cycle-separator-lines 2)

  ;(setq org-modules
    ;'(org-crypt
        ;org-habit
        ;org-bookmark
        ;org-eshell
        ;org-irc))

  (setq org-refile-targets '((nil :maxlevel . 2)
                             (org-agenda-files :maxlevel . 2)))

  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-use-outline-path t)

  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-j") 'org-next-visible-heading)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-k") 'org-previous-visible-heading)

  (evil-define-key '(normal insert visual) org-mode-map (kbd "M-j") 'org-metadown)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "M-k") 'org-metaup)

  (org-babel-do-load-languages
    'org-babel-load-languages
    '((emacs-lisp . t)
      (ledger . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes)

  ;; NOTE: Subsequent sections are still part of this use-package block!

(require 'kraken-org)
;(require 'kraken-workflow)

;; Since we don't want to disable org-confirm-babel-evaluate all
;; of the time, do it around the after-save-hook
(defun kraken/org-babel-tangle-dont-ask ()
  ;; Dynamic scoping to the rescue
  (let ((org-confirm-babel-evaluate nil))
    (org-babel-tangle)))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'kraken/org-babel-tangle-dont-ask
                                              'run-at-end 'only-in-org-mode)))

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Replace list hyphen with dot
;; (font-lock-add-keywords 'org-mode
;;                         '(("^ *\\([-]\\) "
;;                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; Increase the size of various headings
(set-face-attribute 'org-document-title nil :font "Cantarell" :weight 'bold :height 1.3)
(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

;; Make sure org-indent face is available
(require 'org-indent)

;; Ensure that anything that should be fixed-pitch in Org files appears that way
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
(set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

;; TODO: Others to consider
;; '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
;; '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;; '(org-property-value ((t (:inherit fixed-pitch))) t)
;; '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;; '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
;; '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
;; '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

;; This is needed as of Org 9.2
(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src sh"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
(add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
(add-to-list 'org-structure-template-alist '("json" . "src json"))

(use-package org-pomodoro
  :after org
  :config
  (setq org-pomodoro-start-sound "~/.emacs.d/sounds/focus_bell.wav")
  (setq org-pomodoro-short-break-sound "~/.emacs.d/sounds/three_beeps.wav")
  (setq org-pomodoro-long-break-sound "~/.emacs.d/sounds/three_beeps.wav")
  (setq org-pomodoro-finished-sound "~/.emacs.d/sounds/meditation_bell.wav")

  (kraken/leader-key-def
    "op"  '(org-pomodoro :which-key "pomodoro")))

(require 'org-protocol)

(defun kraken/search-org-files ()
  (interactive)
  (counsel-rg "" "~/Notes" nil "Search Notes: "))

(use-package evil-org
  :after org
  :hook ((org-mode . evil-org-mode)
         (org-agenda-mode . evil-org-mode)
         (evil-org-mode . (lambda () (evil-org-set-key-theme '(navigation todo insert textobjects additional)))))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(kraken/leader-key-def
  "o"   '(:ignore t :which-key "org mode")

  "oi"  '(:ignore t :which-key "insert")
  "oil" '(org-insert-link :which-key "insert link")

  "on"  '(org-toggle-narrow-to-subtree :which-key "toggle narrow")

  "os"  '(kraken/counsel-rg-org-files :which-key "search notes")

  "oa"  '(org-agenda :which-key "status")
  "oc"  '(org-capture t :which-key "capture")
  "ox"  '(org-export-dispatch t :which-key "export"))

;; This ends the use-package org-mode block
)

(use-package magit
  :bind ("C-M-;" . magit-status)
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(kraken/leader-key-def
  "g"   '(:ignore t :which-key "git")
  "gs"  'magit-status
  "gd"  'magit-diff-unstaged
  "gc"  'magit-branch-or-checkout
  "gl"   '(:ignore t :which-key "log")
  "glc" 'magit-log-current
  "glf" 'magit-log-buffer-file
  "gb"  'magit-branch
  "gP"  'magit-push-current
  "gp"  'magit-pull-branch
  "gf"  'magit-fetch
  "gF"  'magit-fetch-all
  "gr"  'magit-rebase)

(use-package forge)

(use-package magit-todos
  :defer t)

(use-package git-gutter
  :straight git-gutter-fringe
  :blackout
  :hook ((text-mode . git-gutter-mode)
         (prog-mode . git-gutter-mode))
  :config
  (setq git-gutter:update-interval 2)
  (require 'git-gutter-fringe)
  (set-face-foreground 'git-gutter-fr:added "LightGreen")
  (fringe-helper-define 'git-gutter-fr:added nil
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    ".........."
    ".........."
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    ".........."
    ".........."
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    "XXXXXXXXXX")

  (set-face-foreground 'git-gutter-fr:modified "LightGoldenrod")
  (fringe-helper-define 'git-gutter-fr:modified nil
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    ".........."
    ".........."
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    ".........."
    ".........."
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    "XXXXXXXXXX")

  (set-face-foreground 'git-gutter-fr:deleted "LightCoral")
  (fringe-helper-define 'git-gutter-fr:deleted nil
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    ".........."
    ".........."
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    ".........."
    ".........."
    "XXXXXXXXXX"
    "XXXXXXXXXX"
    "XXXXXXXXXX")

  ;; These characters are used in terminal mode
  (setq git-gutter:modified-sign "≡")
  (setq git-gutter:added-sign "≡")
  (setq git-gutter:deleted-sign "≡")
  (set-face-foreground 'git-gutter:added "LightGreen")
  (set-face-foreground 'git-gutter:modified "LightGoldenrod")
  (set-face-foreground 'git-gutter:deleted "LightCoral"))

(use-package projectile
  :blackout
  :ensure t
  :init
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1)
  :bind 
  (:map projectile-mode-map ("C-c p" . projectile-command-map)))

(use-package counsel-projectile
  :config (counsel-projectile-mode 1))

(kraken/leader-key-def
  "p"  '(:ignore p :which-key "projectile")
  "pf"  'counsel-projectile-find-file
  "ps"  'counsel-projectile-switch-project
  "p/"  'counsel-projectile-rg
  "pp"  'counsel-projectile
  "pa"  'projectile-add-known-project
  "pc"  'projectile-compile-project
  "pd"  'projectile-dired)

(kraken/leader-key-def
  "a"  '(:ignore t :which-key "apps"))

(use-package calfw
  :commands cfw:open-org-calendar
  :config
  (setq cfw:fchar-junction ?╋
        cfw:fchar-vertical-line ?┃
        cfw:fchar-horizontal-line ?━
        cfw:fchar-left-junction ?┣
        cfw:fchar-right-junction ?┫
        cfw:fchar-top-junction ?┯
        cfw:fchar-top-left-corner ?┏
        cfw:fchar-top-right-corner ?┓)

  (use-package calfw-org
    :config
    (setq cfw:org-agenda-schedule-args '(:timestamp))))

(kraken/leader-key-def
  "ac"  '(cfw:open-org-calendar :which-key "calendar"))

(require 'init-key)
(require 'init-lsp)
(require 'init-ui)
(require 'init-flycheck)
(require 'init-dev)
(require 'init-search)
(require 'init-company)
(require 'init-go)
