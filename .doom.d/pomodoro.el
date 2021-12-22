;;; ../myDotFiles/.doom.d/pomodoro.el -*- lexical-binding: t; -*-

  (defun fabien/pomodoro-start-work ()
    (interactive)
    (org-timer-set-timer "20:00"))

  (defun fabien/pomodoro-start-rest ()
    (interactive)
    (org-timer-set-timer "5:00"))

  (defun fabien/pomodoro-pause-continue ()
    (interactive)
    (org-timer-pause-or-continue))
