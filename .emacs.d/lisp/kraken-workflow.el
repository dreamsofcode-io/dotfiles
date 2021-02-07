(setq org-directory
      "~/.org/notes")

(setq org-agenda-files `(,org-directory))

(defun kraken/org-path (path)
  (expand-file-name path org-directory))

(setq org-default-notes-file (kraken/org-path "Inbox.org"))

(setq org-todo-keywords
  '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
    (sequence "|" "WAIT(w)" "BACK(b)")))

;; TODO: org-todo-keyword-faces
(setq org-todo-keyword-faces
  '(("NEXT" . (:foreground "orange red" :weight bold))
    ("WAIT" . (:foreground "HotPink2" :weight bold))
    ("BACK" . (:foreground "MediumPurple3" :weight bold))))

;; Configure common tags
(setq org-tag-alist
  '((:startgroup)
     ; Put mutually exclusive tags here
     (:endgroup)
     ("@home" . ?H)
     ("@work" . ?W)
     ("batch" . ?b)
     ("followup" . ?f)))

(setq org-agenda-window-setup 'current-window)
(setq org-agenda-span 'day)
(setq org-agenda-start-with-log-mode t)

(setq org-agenda-custom-commands
      `(("d" "Dashboard"
         ((agenda "" ((org-deadline-warning-days 7)))
          (tags-todo "+PRIORITY=\"A\""
                     ((org-agenda-overriding-header "High Priority")))
          (tags-todo "+followup" ((org-agenda-overriding-header "Needs Follow Up")))
          (todo "NEXT"
                ((org-agenda-overriding-header "Next Actions")))
          (todo "TODO"
                ((org-agenda-overriding-header "Unprocessed Inbox Tasks")
                 (org-agenda-files '(,(kraken/org-path "Inbox.org")))
                 (org-agenda-text-search-extra-files nil)))))

        ("n" "Next Tasks"
         ((agenda "" ((org-deadline-warning-days 7)))
          (todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))))

        ;; Low-effort next actions
        ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
         ((org-agenda-overriding-header "Low Effort Tasks")
          (org-agenda-max-todos 20)
          (org-agenda-files org-agenda-files)))))

(defun kraken/get-todays-journal-file-name ()
  "Gets the journal file name for today's date"
  (interactive)
  (let* ((journal-file-name
           (expand-file-name
             (format-time-string "%Y/%Y-%2m-%B.org")
             (kraken/org-path "Journal/")))
         (journal-year-dir (file-name-directory journal-file-name)))
    (if (not (file-directory-p journal-year-dir))
      (make-directory journal-year-dir))
    journal-file-name))


(defun kraken/on-org-capture ()
  ;; Don't show the confirmation header text
  (setq header-line-format nil)

  ;; Control how some buffers are handled
  (let ((template (org-capture-get :key t)))
    (pcase template
      ("jj" (delete-other-windows)))))

(add-hook 'org-capture-mode-hook 'kraken/on-org-capture)

(setq org-capture-templates
  `(("t" "Tasks")
    ("tt" "Task" entry (file ,(kraken/org-path "Inbox.org"))
         "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
    ("ts" "Clocked Entry Subtask" entry (clock)
         "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

    ("j" "Journal Entries")
    ("je" "General Entry" entry
         (file+olp+datetree ,(kraken/org-path "Journal.org"))
         "\n* %<%I:%M %p> - %^{Title} \n\n%?\n\n"
         :tree-type week
         :clock-in :clock-resume
         :empty-lines 1)
    ("jt" "Task Entry" entry
         (file+olp+datetree ,(kraken/org-path "Journal.org"))
         "\n* %<%I:%M %p> - Task Notes: %a\n\n%?\n\n"
         :tree-type week
         :clock-in :clock-resume
         :empty-lines 1)
    ("jj" "Journal" entry
         (file+olp+datetree ,(kraken/org-path "Journal.org"))
         "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
         :tree-type week
         :clock-in :clock-resume
         :empty-lines 1)))

(provide 'kraken-workflow)
