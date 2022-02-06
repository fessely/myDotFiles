;; -*- lexical-binding: t; -*-

(defun fe/org-roam-capture-inbox ()
  "Simply capture a new input in inbox"
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                     :templates '(("i" "inbox" plain "* %?"
                                   :if-new (file+head "inbox.org" "#+title: Inbox\n")
                                   )
                                  )
                     )
  )

(defun my/org-roam-filter-by-title (title)
  (lambda (node)
    (member title (org-roam-node-title node))))

(defun my/org-roam-list-notes-by-title (title)
  (mapcar #'org-roam-node-file
          (seq-filter
           (my/org-roam-filter-by-title title)
           (org-roam-node-list))))

(defun my/org-roam-refresh-agenda-list ()
  (interactive)
  (setq org-agenda-files (my/org-roam-list-notes-by-title "later")))
