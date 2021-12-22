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

(defun fabien/org-roam-weekly-this ()
  "Find the weekly-file for this week."
  (interactive)
  (if (equal (format-time-string "%a" (current-time)) "Mon")
      (fabien/org-roam-find-weekly "+0")
  (fabien/org-roam-find-weekly "-mon")))
;; end https://github.com/gcoladon

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
