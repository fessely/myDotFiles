;;; .
;;; ./myDotFiles/.doom.d/angenda-and-roam.el -*- lexical-binding: t; -*-
;;
(defun fabien/node-for-a-week (&optional a-date)
  (format-time-string "Week %U of %Y" a-date)
  )

(defun fabien/org-roam-current-weekly ()
  "Find the weekly-file for this week."
  (interactive)
  (org-roam-node-find nil (fabien/node-for-a-week()))
)

(defun fabien/org-roam-find-weekly ()
  "Find the weekly-file for a week from calendar."
  (interactive)
  (org-roam-node-find nil (fabien/node-for-a-week(org-read-date nil t)))
)
