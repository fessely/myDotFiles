(load! "calendar.el")

(setq user-full-name "Fabien"
      user-mail-address "fabien.essely@gmail.com")

(setq doom-theme 'doom-one)

(setq display-line-numbers-type t)
(custom-set-variables
     '(initial-frame-alist (quote ((fullscreen . maximized)))))

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(set-face-attribute 'default nil :font "Fira Code" :height 140 :weight 'light)

(setq org-directory "~/Groot")
(setq org-agenda-include-diary t)
(setq org-default-notes-file (concat org-directory "/inbox.org"))

(setq org-ditaa-jar-path "~/Groot/Library/ditaa0_9/ditaa0_9.jar")

(require 'org)
(after! org
  (setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))

  (defun fe/org-add-hook-for-tangling ()
       (interactive)
       (add-hook 'after-save-hook #'org-babel-tangle nil t)
  )

  (defun fabien/pomodoro-start-work ()
    (interactive)
    (org-timer-set-timer "20:00"))

  (defun fabien/pomodoro-start-rest ()
    (interactive)
    (org-timer-set-timer "5:00"))

  (defun fabien/pomodoro-pause-continue ()
    (interactive)
    (org-timer-pause-or-continue))
  )

(setq org-roam-directory "~/Groot/Notes")
(setq org-roam-v2-ack t)
(setq org-roam-dailies-directory "dailies")

(require 'org-roam)

(after! org-roam
  (setq org-roam-db-autosync-mode t) ;;auto db sync
  (load!  "workflow.el")
  (defun org-roam-node-insert-immediate (arg &rest args)
    (interactive "P")
    (let ((args (cons arg args))
          (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                    '(:immediate-finish t)))))
      (apply #'org-roam-node-insert args)))

  (defun fabien/update-agenda-files-with-dailies ()
    (interactive)
    ;;remove daily from agenda files
    (setq org-agenda-files
          (cl-remove-if
           (lambda (k) (string-match
                        (concat ".*" org-roam-dailies-directory ".*")
                        k))
           org-agenda-files
           )
          )
    (setq dailies_counter 0)
    ;; select existing dailies in the next 30 days
    (while (< dailies_counter 30)
      (setq daily_path
          (format-time-string
           (concat org-roam-directory "/" org-roam-dailies-directory "/%Y-%m-%d.org")
           (time-add (* dailies_counter 86400)
                     (current-time)
                     )
           )
          )
      (cond  ((file-exists-p daily_path) (push daily_path org-agenda-files)))
      (setq dailies_counter (+ dailies_counter 1))
    )
    )
)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
