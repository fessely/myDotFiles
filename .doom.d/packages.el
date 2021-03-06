(package! org-roam
  :recipe (:host github :repo "org-roam/org-roam"
           :files (:defaults "extensions/*")))

(package! ox-hugo)
;;(package! git-link)
;;(package! yaml-mode)
;;(package! emmet-mode)
;;(package! citeproc-org)
(package! dash)
(package! simple-httpd)
(package! org-present)
(package! websocket)
(package! citar)
(package! org-ref)
(package! org-noter)
(package! org-roam-ui :recipe (:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))
(package! org-roam-bibtex)
;; (package! elfeed)
;; (package! elfeed-score)
