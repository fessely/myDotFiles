;;; ../myDotFiles/.doom.d/search.el -*- lexical-binding: t; -*-

(defun fabien/search-on-google (start end)
  "Get the region, add arxiv to it, and search for it"
  (interactive "r")
  (+lookup/online (concat (buffer-substring-no-properties start end)) "Google"))

(defun fabien/search-on-arxiv (start end)
  "Get the region, add arxiv to it, and search for it"
  (interactive "r")
  (+lookup/online (concat "arxiv " (buffer-substring-no-properties start end)) "Google"))

(defun fabien/search-on-iacr (start end)
  "Get the region, add arxiv to it, and search for it"
  (interactive "r")
  (+lookup/online (concat "iacr " (buffer-substring-no-properties start end)) "Google"))
