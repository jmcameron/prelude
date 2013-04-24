;;; My initialization customizations

;;; (transient-mark-mode 1) ; highlight text selection

;;; Some Emacs windowing preferences
(if (or (eq window-system 'x)
        (eq window-system 'w32))
    (progn
      (transient-mark-mode t)
      (setq mark-even-if-inactive t)
      (setq highlight-nonselected-windows t)
      ;; (set-background-color "Black")
      ;; (set-foreground-color "White")
      (set-face-background 'region "gray50")
      ;; (set-face-foreground 'modeline "Black")
      ;; (set-face-background 'modeline "White")
      (set-cursor-color "White")
      )
  (progn
    (setq mark-even-if-inactive t)
    (transient-mark-mode t)
    )
  )
