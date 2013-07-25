;;; package -- My initialization customizations

;;; Commentary:

;;; Code:


(setq home-base-dir (expand-file-name (concat "~" (user-login-name))))
(setq my-emacs-lib (concat home-base-dir "/lib/emacs/site-lisp"))
(setq load-path (append (list my-emacs-lib) load-path))

;; Enable the arrow keys
(setq prelude-guru nil)

;; Define some autoloads
(autoload 'prefix-region "prefix-region"
  "Insert a prefix to the beginning of each line in the region." t)


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

;;; (transient-mark-mode 1) ; highlight text selection

(put 'eval-expression 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;;; Buffer local settings
(make-variable-buffer-local 'compile-command)

;;; Compilation mode regexp for Sphinx docstring errors
(setq compilation-error-regexp-alist-alist
      (append (list
               '(sphinx "^\\(/home/[^: \n]+\\):\\([0-9]+\\):" 1 2 nil (1))
               '(sphinx2 "^\\(/home/[^: \n]+\\):docstring[^:]+:\\([0-9]+\\):" 1 2 nil (1))
               )
              compilation-error-regexp-alist-alist))

(defun compile-sphinx ()
  "Perform a Sphinx compile"
  (interactive)
  (let ((compilation-error-regexp-alist '(sphinx sphinx2)))
    (compile "cd doc; make clean; cd ..; ymk sphinxdocs |& egrep -v -e '(is not documented|is not a Python function)'")))




;;; Hack from Vivek Haldar to toggle split screen


(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(global-set-key [f11] 'toggle-window-split)



(defun whack-whitespace (arg)
  "Delete all white space from point to the next word.  With prefix ARG
    delete across newlines as well.  The only danger in this is that you
    don't have to actually be at the end of a word to make it work.  It
    skips over to the next whitespace and then whacks it all to the next
    word.  From: http://www.emacswiki.org/emacs/DeletingWhitespace"
  (interactive "P")
  (let ((regexp (if arg "[ \t\n]+" "[ \t]+")))
    (re-search-forward regexp nil t)
    (replace-match "" nil nil)))

(global-set-key [f10] 'whack-whitespace)
