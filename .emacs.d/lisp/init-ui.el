;; init-ui.el

(setq enable-recursive-minibuffers t)

;; Package `selectrum' is an incremental completion and narrowing
;; framework. Like Ivy and Helm, which it improves on, Selectrum
;; provides a user interface for choosing from a list of options by
;; typing a query to narrow the list, and then selecting one of the
;; remaining candidates. This offers a significant improvement over
;; the default Emacs interface for candidate selection.
(use-package selectrum
  :straight (:host github :repo "raxod502/selectrum")
  :custom
  (selectrum-count-style 'current/matches)
  ;; The default 10 seem to cutoff the last line for my screen
  (selectrum-max-window-height 12)
  :init
  ;; This doesn't actually load Selectrum.
  (selectrum-mode +1)
  (kraken/leader-key-def "TAB" #'selectrum-repeat))

;; Package `prescient' is a library for intelligent sorting and
;; filtering in various contexts.
(use-package prescient
  :config
  ;; Remember usage statistics across Emacs sessions.
  (prescient-persist-mode +1)
  ;; The default settings seem a little forgetful to me. Let's try
  ;; this out.
  (setq prescient-history-length 1000))

;; Package `selectrum-prescient' provides intelligent sorting and
;; filtering for candidates in Selectrum menus.
(use-package selectrum-prescient
  :straight (:host github :repo "raxod502/prescient.el"
                   :files ("selectrum-prescient.el"))
  :after selectrum
  :config
  (selectrum-prescient-mode +1))

(use-package autorevert
  :defer t
  :blackout auto-revert-mode)

(setq inhibit-startup-message t)

(setq frame-inhibit-implied-resize t)

;; No beeping nor visible bell
(setq ring-bell-function #'ignore
      visible-bell nil)

(blink-cursor-mode 0)

(setq-default line-spacing 0.1)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq use-dialog-box nil) ;; Disable dialog boxes since they weren't working in Mac OSX

(provide 'init-ui)

