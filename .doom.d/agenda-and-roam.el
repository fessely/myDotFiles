;;; .
;;; ./myDotFiles/.doom.d/angenda-and-roam.el -*- lexical-binding: t; -*-
;; TODO refile org dailies into weekly file

(defun fe/org-roam-goto-week (which)
  "Find file corresponding to the week beginning with WHICH"
  (setq monday-tv (org-read-date nil t which))
  (let ((monday-str (org-read-date nil nil which)))
    (org-roam-node-find nil
     (concat "Week of " monday-str)) nil nil t))

(defun fe/org-roam-goto-current-week ()
  "Find the weekly-file for this week."
  (interactive)
  (if (equal (format-time-string "%a" (current-time)) "Mon")
      (fe/org-roam-goto-week "+0")
  (fe/org-roam-goto-week "-mon")))
