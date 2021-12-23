;;; .
;;; ./myDotFiles/.doom.d/angenda-and-roam.el -*- lexical-binding: t; -*-
;; TODO refile org dailies into weekly file



;; thanks to https://github.com/gcoladon
(defun fabien/org-roam-find-weekly (which)
  "Find file corresponding to the week beginning with WHICH"
  (setq monday-tv (org-read-date nil t which))
  (let ((monday-str (org-read-date nil nil which)))
    (org-roam-node-find nil
     (concat "Week of " monday-str)) nil nil t))
;; end https://github.com/gcoladon
;;
(defun fabien/org-roam-current-weekly ()
  "Find the weekly-file for this week."
  (interactive)
  (fabien/org-roam-find-weekly (if (string-equal (format-time-string "%A") "Monday") "+0" "-mon"))
  )


(defun fabien/org-roam-refile-to-weekly (start end)
  (interactive "r")
  ;; destination file

  (if (equal (format-time-string "%a" (current-time)) "Mon")
      (setq weekly-file "+0")
    (setq weekly-file "-mon"))

  (setq weekly-file (if (string-equal (format-time-string "%A") "Monday") "+0" "-mon"))

  (setq weekly-file (org-read-date nil nil weekly-file))
  (setq weekly-file (concat "Week of " weekly-file ".org"))
  (org-refile-copy )
  )


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
