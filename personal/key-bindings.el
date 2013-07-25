;;; package --- My key bindings

;;; Commentary:

;;; Code:

(global-set-key "\C-x/"      'point-to-register)
(global-set-key "\C-xj"      'jump-to-register)

(global-set-key "\C-\\"      'overwrite-mode)

(global-set-key "\C-c\C-f"
                '(lambda (arg) "Insert find sequence (use prefix > 1 for two patterns)"
                   (interactive "p")
                   (if (eq arg 1)
                       (insert (concat "find . -name '*.py' -exec grep -nH ? {} \\;"))
                     (insert "find . \\( -name '*.h' -o -name '*.c*' \\) -exec grep -nH ? {} \\;")
                     )))

(global-set-key "\M-\C-c"    'compile)
(global-set-key "\M-\C-l"    'goto-line)

(global-set-key [f5]  'compile)
(global-set-key [f6]  'shrink-window)
(global-set-key [f7]  'enlarge-window)
(global-set-key [f8]  'next-error)
(global-set-key [f9]  'scroll-down)
(global-set-key [f10] 'scroll-up)
