(defun concatenate-authors (authors-list)
    "Given AUTHORS-LIST, list of plists; return string of all authors concatenated."
    (if (> (length authors-list) 1)
      (format "%s et al." (plist-get (nth 0 authors-list) :name))
    (plist-get (nth 0 authors-list) :name)))

  (defun my-search-print-fn (entry)
    "Print ENTRY to the buffer."
    (let* ((date (elfeed-search-format-date (elfeed-entry-date entry)))
           (title (or (elfeed-meta entry :title)
                      (elfeed-entry-title entry) ""))
           (title-faces (elfeed-search--faces (elfeed-entry-tags entry)))
           (entry-authors (concatenate-authors
                           (elfeed-meta entry :authors)))
         (title-width (- (window-width) 10
                         elfeed-search-trailing-width))
         (title-column (elfeed-format-column
                        title 100
                        :left))
         ;;(entry-score (elfeed-format-column (number-to-string (elfeed-score-scoring-get-score-from-entry entry)) 10 :left))
         (authors-column (elfeed-format-column entry-authors 40 :left)))
    (insert (propertize date 'face 'elfeed-search-date-face) " ")

    (insert (propertize title-column
                        'face title-faces 'kbd-help title) " ")
    (insert (propertize authors-column
                        'kbd-help entry-authors) " ")
    ;;(insert entry-score " ")
    ))

(defun fabien/elfeed-entry-to-arxiv ()
  "Fetch an arXiv paper into the local library from the current elfeed entry."
  (interactive)
  (let* ((link (elfeed-entry-link elfeed-show-entry))
         (match-idx (string-match "arxiv.org/abs/\\([0-9.]*\\)" link))
         (matched-arxiv-number (match-string 1 link)))
    (when matched-arxiv-number
      (message "Going to arXiv: %s" matched-arxiv-number)
      (arxiv-get-pdf-add-bibtex-entry matched-arxiv-number bibtex-completion-bibliography bibtex-completion-library-path))))

(map! (:after elfeed
       (:map elfeed-search-mode-map
        :desc "Open entry" "m" #'elfeed-search-show-entry)
       (:map elfeed-show-mode-map
        :desc "Fetch arXiv paper to the local library" "a" #'fabien/elfeed-entry-to-arxiv)))

;;(setq elfeed-search-print-entry-function #'my-search-print-fn)
  (setq elfeed-search-date-format '("%y-%m-%d" 10 :left))
  (setq elfeed-search-title-max-width 110)
  (setq my-arxiv-templates "http://export.arxiv.org/api/query?search_query=cat:%s&start=0&max_results=%d&sortBy=submittedDate&sortOrder=descending")
  (setq my-arxiv-selection (list "math.OC" "stat.ML"))

  (setq elfeed-feeds (mapcar (lambda (n) (format my-arxiv-templates n 100)) my-arxiv-selection))
  (add-to-list 'elfeed-feeds "http://eprint.iacr.org/rss/atom.xml")
  (setq elfeed-search-filter "@2-week-ago +unread")
;;; ../myDotFiles/.doom.d/elfedd-config.el -*- lexical-binding: t; -*-
