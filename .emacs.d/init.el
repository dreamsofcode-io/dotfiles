;; Variable for font sizing
(defvar dreams/default-font-size 100)
(defvar dreams/default-variable-font-size 120)

;; Make frame transparency overridable
(defvar dreams/frame-transparency '(90 . 90))

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

(straight-use-package 'org)

(push "~/.emacs.d/lisp" load-path)

(server-start)

(setq dreams/exwm-enabled (and (eq window-system 'x)
                           (seq-contains command-line-args "--use-exwm")))

(when dreams/exwm-enabled
  (require dreams-desktop))

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

(defun dreams/evil-hook ()
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

(defun dreams/dont-arrow-me-bro ()
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
  (add-hook 'evil-mode-hook 'dreams/evil-hook)
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ;; Disable arrow keys in normal and visual modes
  (define-key evil-normal-state-map (kbd "<left>") 'dreams/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<right>") 'dreams/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<down>") 'dreams/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<up>") 'dreams/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<left>") 'dreams/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<right>") 'dreams/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<down>") 'dreams/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<up>") 'dreams/dont-arrow-me-bro)

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

  (general-create-definer dreams/leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general-create-definer dreams/ctrl-c-keys
    :prefix "C-c"))

(use-package blackout
  :straight (:host github :repo "raxod502/blackout"))

(use-package which-key
  :blackout t
  :hook (after-init . which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5))

(use-package catppuccin-theme
  :init (load-theme 'catppuccin t))

(set-face-attribute 'default nil
  :font "JetBrainsMono Nerd Font" 
  :height dreams/default-font-size
  :weight 'medium)

(set-face-attribute 'fixed-pitch nil 
  :font "JetBrainsMono Nerd Font" 
  :height dreams/default-font-size)

(set-face-attribute 'variable-pitch nil 
  :font "Poppins"
  :height dreams/default-variable-font-size
  :weight 'regular)

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package alert
  :commands alert
  :config
  (setq alert-default-style 'notifications))

(dreams/leader-key-def
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

(dreams/leader-key-def
  "tp" 'parinfer-toggle-mode)

(use-package origami
  :hook (yaml-mode . origami-mode))

;; TODO: Mode this to another section
(setq-default fill-column 80)

;; Turn on indentation and auto-fill mode for Org files
(defun dreams/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil)
  (blackout org-indent-mode))

(use-package org
  :defer t
  ;:hook (org-mode . dreams/org-mode-setup)
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

  (setq org-modules
    '(org-crypt
        org-habit
        org-bookmark
        org-eshell
        org-irc))

  ;(setq org-refile-targets '((nil :maxlevel . 2)
                             ;(org-agenda-files :maxlevel . 2)))

  ;(setq org-outline-path-complete-in-steps nil)
  ;(setq org-refile-use-outline-path t)

  ;(evil-define-key '(normal insert visual) org-mode-map (kbd "C-j") 'org-next-visible-heading)
  ;(evil-define-key '(normal insert visual) org-mode-map (kbd "C-k") 'org-previous-visible-heading)

  ;(evil-define-key '(normal insert visual) org-mode-map (kbd "M-j") 'org-metadown)
  ;(evil-define-key '(normal insert visual) org-mode-map (kbd "M-k") 'org-metaup)

  ;(org-babel-do-load-languages
    ;'org-babel-load-languages
    ;'((emacs-lisp . t)
      ;(ledger . t)))

  ;(push '("conf-unix" . conf-unix) org-src-lang-modes)

  ;; NOTE: Subsequent sections are still part of this use-package block!

(require 'dreams-org)
;(require 'dreams-workflow)

;; Since we don't want to disable org-confirm-babel-evaluate all
;; of the time, do it around the after-save-hook
(defun dreams/org-babel-tangle-dont-ask ()
  ;; Dynamic scoping to the rescue
  (let ((org-confirm-babel-evaluate nil))
    (org-babel-tangle)))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'dreams/org-babel-tangle-dont-ask
                                              'run-at-end 'only-in-org-mode)))

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Replace list hyphen with dot
(font-lock-add-keywords 'org-mode
                         '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; Increase the size of various headings
;(set-face-attribute 'org-document-title nil :font "Cantarell" :weight 'bold :height 1.3)
;(dolist (face '((org-level-1 . 1.2)
;                (org-level-2 . 1.1)
;                (org-level-3 . 1.05)
;                (org-level-4 . 1.0)
;                (org-level-5 . 1.1)
;                (org-level-6 . 1.1)
;                (org-level-7 . 1.1)
;                (org-level-8 . 1.1)))
;  (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

;; Make sure org-indent face is available
(require 'org-indent)

;; Ensure that anything that should be fixed-pitch in Org files appears that way
;(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
;(set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
;(set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
;(set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
;(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
;(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
;(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
;(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
;(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

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

;(use-package org-pomodoro
  ;:after org
  ;:config
  ;(setq org-pomodoro-start-sound "~/.emacs.d/sounds/focus_bell.wav")
  ;(setq org-pomodoro-short-break-sound "~/.emacs.d/sounds/three_beeps.wav")
  ;(setq org-pomodoro-long-break-sound "~/.emacs.d/sounds/three_beeps.wav")
  ;(setq org-pomodoro-finished-sound "~/.emacs.d/sounds/meditation_bell.wav")

  ;(dreams/leader-key-def
    ;"op"  '(org-pomodoro :which-key "pomodoro")))

(require 'org-protocol)

(defun dreams/search-org-files ()
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

(dreams/leader-key-def
  "o"   '(:ignore t :which-key "org mode")

  "oi"  '(:ignore t :which-key "insert")
  "oil" '(org-insert-link :which-key "insert link")

  "on"  '(org-toggle-narrow-to-subtree :which-key "toggle narrow")

  "os"  '(dreams/counsel-rg-org-files :which-key "search notes")

  "oa"  '(org-agenda :which-key "status")
  "oc"  '(org-capture t :which-key "capture")
  "ox"  '(org-export-dispatch t :which-key "export"))

;; This ends the use-package org-mode block
)

(dreams/leader-key-def
  "c" '(:ignore t :which-key "code"))

(use-package magit
  :bind ("C-M-;" . magit-status)
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(dreams/leader-key-def
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

(dreams/leader-key-def
  "p"  '(:ignore p :which-key "projectile")
  "pf"  'counsel-projectile-find-file
  "ps"  'counsel-projectile-switch-project
  "p/"  'counsel-projectile-rg
  "pp"  'counsel-projectile
  "pa"  'projectile-add-known-project
  "pc"  'projectile-compile-project
  "pd"  'projectile-dired)

(use-package lsp-mode
  :straight t
  :commands lsp
  :hook ((go-mode) . lsp)
  :bind (:map lsp-mode-map
         ("TAB" . completion-at-point)))

(dreams/leader-key-def
  "l"  '(:ignore t :which-key "lsp")
  "ld" 'xref-find-definitions
  "lr" 'xref-find-references
  "ln" 'lsp-ui-find-next-reference
  "lp" 'lsp-ui-find-prev-reference
  "ls" 'counsel-imenu
  "le" 'lsp-ui-flycheck-list
  "lS" 'lsp-ui-sideline-mode
  "lX" 'lsp-execute-code-action)

(use-package lsp-ui
  :straight t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  ;(setq lsp-ui-sideline-enable t)
  ;(setq lsp-ui-sideline-show-hover nil)
  ;(lsp-ui-doc-show))
  )

(use-package go-mode
      :functions (go-packages-gopkgs go-update-tools)
      :bind (:map go-mode-map
             ("C-c R" . go-remove-unused-imports)
             ("<f1>" . godoc-at-point))
      :config
      ;; Env vars
      (with-eval-after-load 'exec-path-from-shell
        (exec-path-from-shell-copy-envs '("GOPATH" "GO111MODULE" "GOPROXY")))

      ;; Install or update tools
      (defvar go--tools '("golang.org/x/tools/cmd/goimports"
                          "github.com/go-delve/delve/cmd/dlv"
                          "github.com/josharian/impl"
                          "github.com/cweill/gotests/..."
                          "github.com/fatih/gomodifytags"
                          "github.com/davidrjenni/reftools/cmd/fillstruct")
        "All necessary go tools.")

      ;; Do not use the -u flag for gopls, as it will update the dependencies to incompatible versions
      ;; https://github.com/golang/tools/blob/master/gopls/doc/user.md#installation
      (defvar go--tools-no-update '("golang.org/x/tools/gopls@latest")
        "All necessary go tools without update the dependencies.")

      (defun go-update-tools ()
        "Install or update go tools."
        (interactive)
        (unless (executable-find "go")
          (user-error "Unable to find `go' in `exec-path'!"))

        (message "Installing go tools...")
        (let ((proc-name "go-tools")
              (proc-buffer "*Go Tools*"))
          (dolist (pkg go--tools-no-update)
            (set-process-sentinel
             (start-process proc-name proc-buffer "go" "get" "-v" pkg)
             (lambda (proc _)
               (let ((status (process-exit-status proc)))
                 (if (= 0 status)
                     (message "Installed %s" pkg)
                   (message "Failed to install %s: %d" pkg status))))))

          (dolist (pkg go--tools)
            (set-process-sentinel
             (start-process proc-name proc-buffer "go" "get" "-u" "-v" pkg)
             (lambda (proc _)
               (let ((status (process-exit-status proc)))
                 (if (= 0 status)
                     (message "Installed %s" pkg)
                   (message "Failed to install %s: %d" pkg status))))))))

      ;; Try to install go tools if `gopls' is not found
      (unless (executable-find "gopls")
        (go-update-tools))

      ;; Misc
      (use-package go-dlv)
      (use-package go-fill-struct)
      (use-package go-impl)

      ;; Install: See https://github.com/golangci/golangci-lint#install
      (use-package flycheck-golangci-lint
        :if (executable-find "golangci-lint")
        :after flycheck
        :defines flycheck-disabled-checkers
        :hook (go-mode . (lambda ()
                           "Enable golangci-lint."
                           (setq flycheck-disabled-checkers '(go-gofmt
                                                              go-golint
                                                              go-vet
                                                              go-build
                                                              go-test
                                                              go-errcheck))
                           (flycheck-golangci-lint-setup))))

      (use-package go-tag
        :bind (:map go-mode-map
               ("C-c t t" . go-tag-add)
               ("C-c t T" . go-tag-remove))
        :init (setq go-tag-args (list "-transform" "camelcase")))

      (use-package go-gen-test
        :bind (:map go-mode-map
               ("C-c t g" . go-gen-test-dwim)))

      (use-package gotest
        :general (:keymaps 'org-mode-map (dreams/leader-key-def "mta" 'go-test-current-project))
        :bind (:map go-mode-map
               ("C-c t a" . go-test-current-project)
               ("C-c t m" . go-test-current-file)
               ("C-c t ." . go-test-current-test)
               ("C-c t x" . go-run))))

    ;; Local Golang playground for short snippets
    (use-package go-playground
      :blackout
      :commands (go-playground-mode))

; load go bin dir into emacs path
(add-to-list 'exec-path (expand-file-name "~/go/bin"))

(use-package rust-mode
  :mode "\\.rs\\'"
  :init (setq rust-format-on-save t))

;(use-package cargo
;  :straight t
;  :defer t)

(use-package yaml-mode
  :mode "\\.ya?ml\\'")

(use-package company
  :blackout
  :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
  :commands company-cancel
  :bind (("M-/" . company-complete)
         ("C-M-i" . company-complete)
         :map company-mode-map
         ("<backtab>" . company-yasnippet)
         :map company-active-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next)
         ("<tab>" . company-complete-common-or-cycle)
         ("<backtab>" . my-company-yasnippet)
         :map company-search-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next))
  :hook (after-init . global-company-mode)
  :init
  (setq company-tooltip-align-annotations t
        company-tooltip-limit 12
        company-idle-delay 0
        company-echo-delay (if (display-graphic-p) nil 0)
        company-minimum-prefix-length 1
        company-require-match nil
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-global-modes '(not erc-mode message-mode help-mode
                                   gud-mode eshell-mode shell-mode)
        company-backends '((company-capf :with company-yasnippet)
                           (company-dabbrev-code company-keywords company-files)
                           company-dabbrev))

  (defun my-company-yasnippet ()
    "Hide the current completeions and show snippets."
    (interactive)
    (company-cancel)
    (call-interactively 'company-yasnippet))
  :config
  ;; `yasnippet' integration
  (with-no-warnings
    (with-eval-after-load 'yasnippet
      (defun company-backend-with-yas (backend)
        "Add `yasnippet' to company backend."
        (if (and (listp backend) (member 'company-yasnippet backend))
            backend
          (append (if (consp backend) backend (list backend))
                  '(:with company-yasnippet))))

      (defun my-company-enbale-yas (&rest _)
        "Enable `yasnippet' in `company'."
        (setq company-backends (mapcar #'company-backend-with-yas company-backends)))

      (defun my-lsp-fix-company-capf ()
        "Remove redundant `comapny-capf'."
        (setq company-backends
              (remove 'company-backends (remq 'company-capf company-backends))))
      (advice-add #'lsp-completion--enable :after #'my-lsp-fix-company-capf)

      (defun my-company-yasnippet-disable-inline (fun command &optional arg &rest _ignore)
        "Enable yasnippet but disable it inline."
        (if (eq command 'prefix)
            (when-let ((prefix (funcall fun 'prefix)))
              (unless (memq (char-before (- (point) (length prefix)))
                            '(?. ?< ?> ?\( ?\) ?\[ ?{ ?} ?\" ?' ?`))
                prefix))
          (progn
            (when (and (bound-and-true-p lsp-mode)
                       arg (not (get-text-property 0 'yas-annotation-patch arg)))
              (let* ((name (get-text-property 0 'yas-annotation arg))
                     (snip (format "%s (Snippet)" name))
                     (len (length arg)))
                (put-text-property 0 len 'yas-annotation snip arg)
                (put-text-property 0 len 'yas-annotation-patch t arg)))
            (funcall fun command arg))))
      (advice-add #'company-yasnippet :around #'my-company-yasnippet-disable-inline)))

  ;; Better sorting and filtering
  (use-package company-prescient
    :init (company-prescient-mode 1))

  ;; Icons and quickhelp
  (use-package company-box
	  :diminish
	  :defines company-box-icons-all-the-icons
	  :hook (company-mode . company-box-mode)
	  :init (setq
				   company-box-backends-colors nil
				   company-box-doc-delay 0.3)
	  :config
	  (with-no-warnings
	    ;; Prettify icons
	    (defun my-company-box-icons--elisp (candidate)
		    (when (or (derived-mode-p 'emacs-lisp-mode) (derived-mode-p 'lisp-mode))
		      (let ((sym (intern candidate)))
			      (cond ((fboundp sym) 'Function)
				          ((featurep sym) 'Module)
				          ((facep sym) 'Color)
				          ((boundp sym) 'Variable)
				          ((symbolp sym) 'Text)
				          (t . nil)))))
	    (advice-add #'company-box-icons--elisp :override #'my-company-box-icons--elisp))

	  (declare-function all-the-icons-faicon 'all-the-icons)
	  (declare-function all-the-icons-material 'all-the-icons)
	  (declare-function all-the-icons-octicon 'all-the-icons)
	  (setq company-box-icons-all-the-icons
			    `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.8 :v-adjust -0.15))
			      (Text . ,(all-the-icons-faicon "text-width" :height 0.8 :v-adjust -0.02))
			      (Method . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
			      (Function . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
			      (Constructor . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
			      (Field . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
			      (Variable . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
			      (Class . ,(all-the-icons-material "settings_input_component" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
			      (Interface . ,(all-the-icons-material "share" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
			      (Module . ,(all-the-icons-material "view_module" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
			      (Property . ,(all-the-icons-faicon "wrench" :height 0.8 :v-adjust -0.02))
			      (Unit . ,(all-the-icons-material "settings_system_daydream" :height 0.8 :v-adjust -0.15))
			      (Value . ,(all-the-icons-material "format_align_right" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
			      (Enum . ,(all-the-icons-material "storage" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
			      (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.8 :v-adjust -0.15))
			      (Snippet . ,(all-the-icons-material "format_align_center" :height 0.8 :v-adjust -0.15))
			      (Color . ,(all-the-icons-material "palette" :height 0.8 :v-adjust -0.15))
			      (File . ,(all-the-icons-faicon "file-o" :height 0.8 :v-adjust -0.02))
			      (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.8 :v-adjust -0.15))
			      (Folder . ,(all-the-icons-faicon "folder-open" :height 0.8 :v-adjust -0.02))
			      (EnumMember . ,(all-the-icons-material "format_align_right" :height 0.8 :v-adjust -0.15))
			      (Constant . ,(all-the-icons-faicon "square-o" :height 0.8 :v-adjust -0.1))
			      (Struct . ,(all-the-icons-material "settings_input_component" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
			      (Event . ,(all-the-icons-octicon "zap" :height 0.8 :v-adjust 0 :face 'all-the-icons-orange))
			      (Operator . ,(all-the-icons-material "control_point" :height 0.8 :v-adjust -0.15))
			      (TypeParameter . ,(all-the-icons-faicon "arrows" :height 0.8 :v-adjust -0.02))
			      (Template . ,(all-the-icons-material "format_align_left" :height 0.8 :v-adjust -0.15)))
			    company-box-icons-alist 'company-box-icons-all-the-icons)))

(use-package flycheck
  :defer t
  :hook (lsp-mode . flycheck-mode))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package treemacs
  :commands (treemacs-follow-mode
             treemacs-filewatch-mode
             treemacs-fringe-indicator-mode
             treemacs-git-mode)
  :bind (([f8]        . treemacs)
         ("M-0"       . treemacs-select-window)
         ("C-x 1"     . treemacs-delete-other-windows)
         ("C-x t 1"   . treemacs-delete-other-windows)
         ("C-x t t"   . treemacs)
         ("C-x t b"   . treemacs-bookmark)
         ("C-x t C-t" . treemacs-find-file)
         ("C-x t M-t" . treemacs-find-tag)
         :map treemacs-mode-map
         ([mouse-1]   . treemacs-single-click-expand-action))
  :config
  (setq treemacs-collapse-dirs           (if treemacs-python-executable 3 0)
        treemacs-missing-project-action  'remove
        treemacs-sorting                 'alphabetic-asc
        treemacs-follow-after-init       t
        treemacs-width                   30))
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (pcase (cons (not (null (executable-find "git")))
               (not (null (executable-find "python3"))))
    (`(t . t)
     (treemacs-git-mode 'deferred))
    (`(t . _)
     (treemacs-git-mode 'simple)))

  (use-package treemacs-projectile
    :after projectile
    :bind (:map projectile-command-map
           ("h" . treemacs-projectile)))

  (use-package treemacs-magit
    :after magit
    :commands treemacs-magit--schedule-update
    :hook ((magit-post-commit
            git-commit-post-finish
            magit-post-stage
            magit-post-unstage)
           . treemacs-magit--schedule-update))

  (use-package treemacs-persp
    :after persp-mode
    :demand t
    :functions treemacs-set-scope-type
    :config (treemacs-set-scope-type 'Perspectives))

(dreams/leader-key-def
  "ct" 'treemacs
  "pt" 'treemacs-projectile)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

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

(dreams/leader-key-def
  "a"  '(:ignore t :which-key "apps"))

;(use-package calfw
  ;:commands cfw:open-org-calendar
  ;:config
  ;(setq cfw:fchar-junction ?╋
  ;      cfw:fchar-vertical-line ?┃
  ;      cfw:fchar-horizontal-line ?━
  ;      cfw:fchar-left-junction ?┣
  ;      cfw:fchar-right-junction ?┫
  ;      cfw:fchar-top-junction ?┯
  ;      cfw:fchar-top-left-corner ?┏
  ;      cfw:fchar-top-right-corner ?┓)

  ;(use-package calfw-org
  ;  :config
  ;  (setq cfw:org-agenda-schedule-args '(:timestamp))))

;(dreams/leader-key-def
  ;"ac"  '(cfw:open-org-calendar :which-key "calendar"))

(require 'init-key)
(require 'init-ui)
(require 'init-search)
