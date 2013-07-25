;;; package -- Some programming mode settings

;;; Commentary:

;;; Code:

(add-hook 'bibtex-mode-hook
          '(lambda ()
             (setq bibtex-include-OPTcrossref nil
                   bibtex-include-OPTkey nil
                   bibtex-include-OPTannote nil
                   bibtex-mode-user-optional-fields
                   '("keywords" "filekey" "dateread" "abstract"))
             ))


;; ??? (defconst jmc-c-style
;; ???   '("JMC-C-STYLE"
;; ???     (c-basic-offset . 4)
;; ???
;; ???     (c-comment-only-line-offset . 0)
;; ???
;; ???     (c-hanging-braces-alist . ((defun after)
;; ???                                (block-open after)
;; ???                                (brace-list-open)
;; ???                                ))
;; ???
;; ???     (c-hanging-colons-alist . ((member-init-intro before)
;; ???                                (inher-intro)
;; ???                                (case-label after)
;; ???                                (label after)
;; ???                                (access-key after)
;; ???                                ))
;; ???
;; ???     (c-offsets-alist        . ((arglist-close . c-lineup-arglist)
;; ???                                (substatement-open . 0)
;; ???                                (block-open . 0)
;; ???                                (inline-open . 0)
;; ???                                (block-close . jmc-c-adaptive-block-close)
;; ???                                (label . -)
;; ???                                (statement-cont . +)
;; ???                                ))
;; ???
;; ???     (c-cleanup-list         . (scope-operator
;; ???                                empty-defun-braces
;; ???                                defun-close-semi
;; ???                                ))
;; ???     ))


(add-hook 'c-mode-common-hook
          '(lambda ()
;; ???              (let ((my-style "JMC-C-STYLE"))
;; ???                (or (assoc my-style c-style-alist)
;; ???                    (setq c-style-alist (cons jmc-c-style c-style-alist)))
;; ???                (c-set-style my-style))
             (define-key c-mode-map [return]  'newline-and-indent)
             (setq indent-tabs-mode nil)
             (setq compile-command "make -k ")
             (setq compilation-finish-function
                   '(lambda (arg1 arg2)
                      (beep)))
             ))

(add-hook 'c-mode-hook
          '(lambda ()
             (define-key c-mode-map "\C-c\r"    'insert-c-big-comment)
             (define-key c-mode-map "\C-c\C-f"  'insert-c-function-comment)

             (defun flymake-clang-c-init ()
               (let* ((temp-file (flymake-init-create-temp-buffer-copy
                                  'flymake-create-temp-inplace))
                      (local-file (file-relative-name
                                   temp-file
                                   (file-name-directory buffer-file-name))))

                 (list "clang" (list "-fsyntax-only" "-fno-color-diagnostics" local-file))))

             (defun flymake-clang-c-load ()
               (interactive)
               (unless (eq buffer-file-name nil)
                 (add-to-list 'flymake-allowed-file-name-masks
                              '("\\.c\\'" flymake-clang-c-init))
                 (add-to-list 'flymake-allowed-file-name-masks
                              '("\\.h\\'" flymake-clang-c-init))
                 (flymake-mode t)))
             ))


(add-hook 'c++-mode-hook
          '(lambda ()
             (define-key c++-mode-map "\C-c\r"    'insert-c++-big-comment)
             (define-key c++-mode-map "\C-c\C-f"  'insert-c++-function-comment)
             (define-key c++-mode-map "\C-c\C-d"  'demangle)
             (define-key c++-mode-map [S-down-mouse-3] 'function-menu)
             (setq *prefix-string* "// ")

             (defun flymake-clang-c++-init ()
               (let* ((temp-file (flymake-init-create-temp-buffer-copy
                                  'flymake-create-temp-inplace))
                      (local-file (file-relative-name
                                   temp-file
                                   (file-name-directory buffer-file-name))))
                 (list "clang++" (list "-fsyntax-only" "-fno-color-diagnostics" local-file))))

             (defun flymake-clang-c++-load ()
               (interactive)
               (unless (eq buffer-file-name nil)
                 (if (file-writable-p (file-name-directory buffer-file-name))
                     (progn
                       (add-to-list 'flymake-allowed-file-name-masks
                                    '("\\.cpp\\'" flymake-clang-c++-init))
                       (add-to-list 'flymake-allowed-file-name-masks
                                    '("\\.cc\\'" flymake-clang-c++-init))
                       (add-to-list 'flymake-allowed-file-name-masks
                                    '("\\.h\\'" flymake-clang-c++-init))
                       (flymake-mode t)))))

             (flymake-clang-c++-load)
             ))


;;                    (local-dir ))


;; Turn on font lock when in DTD mode
(add-hook 'dtd-mode-hooks
          'turn-on-font-lock)

;; (autoload 'html-mode "html-mode" "HTML major mode." t)
(add-hook 'html-mode-hook
          '(lambda ()
             (define-key html-mode-map "\C-cb"  '(lambda () "Add tags for bold"
                                                   (interactive)
                                                   (insert "<b></b>")))
             (turn-on-auto-fill)
             (setq spell-filter nil)

             (defun flymake-html-init ()
               (let* ((temp-file (flymake-init-create-temp-buffer-copy
                                  'flymake-create-temp-inplace))
                      (local-file (file-relative-name
                                   temp-file
                                   (file-name-directory buffer-file-name))))
                 (list "tidy" (list local-file))))


             (add-to-list 'flymake-allowed-file-name-masks
                          '("\\.html\\'" flymake-html-init))

             (add-to-list 'flymake-err-line-patterns
                          '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
                            nil 1 2 4))
             ))

(add-hook 'java-mode-hook
          '(lambda ()
             (define-key java-mode-map "\C-c\r"    'insert-c++-big-comment)
             (define-key java-mode-map "\C-c\C-f"  'insert-c++-function-comment)
             (setq *prefix-string* "// ")
             (setq compile-command "javac ")
             (setq compilation-finish-function
                   '(lambda (arg1 arg2)
                      (beep)))
             ))

(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (setq *prefix-string* ";; ")
             ))

(add-hook 'php-mode-hook
          '(lambda ()
             (turn-on-font-lock)
             (setq indent-tabs-mode t)
             (setq tab-width 4)
             (setq compile-command "find . -name '*.php' -exec grep -nH ? {} \\;")
             (setq *prefix-string* "// ")
             (flymake-php-load)
             ))

(add-hook 'latex-mode-hook
          '(lambda ()
             (turn-on-auto-fill)
             (setq spell-filter 'nill)
             ;; (setq spell-filter 'delatex)
             (setq *prefix-string* "% ")
             ))

(add-hook 'matlab-mode-hook
          '(lambda ()
             (define-key matlab-mode-map "\C-c\C-h" 'insert-matlab-file-comment)
             (define-key matlab-mode-map [C-f9] '(lambda () (interactive)
                                                   (insert "    ")))
             (setq *prefix-string* "% ")
             ))

(add-hook 'rst-mode-hook
          '(lambda ()
             (setq frame-background-mode 'dark)
             (set-face-background 'rst-level-1-face  "gray40")
             (set-face-background 'rst-level-2-face  "gray30")
             (set-face-background 'rst-level-3-face  "gray25")
             (set-face-background 'rst-level-4-face  "gray20")
             (set-face-background 'rst-level-5-face  "gray15")
             (set-face-background 'rst-level-6-face  "gray10")
             ; (setq rst-level-face-base-color "blue")
             ; (setq rst-level-face-base-light 30)
             ; (setq rst-level-face-step-light -20)
             (turn-on-font-lock)
             ))

(add-hook 'tcl-mode-hook
          '(lambda ()
             (define-key tcl-mode-map "\C-c\C-f"  'insert-tcl-proc-comment)
             (setq *prefix-string* "# ")
             ))

(add-hook 'tex-mode-hook
          '(lambda ()
             (turn-on-auto-fill)
             (setq spell-filter 'nil)
             ;; (setq spell-filter 'delatex)
             (setq *prefix-string* "% ")
             ))

(add-hook 'mail-mode-hook
          ;; Note: mail-mode runs text-mode-hooks before this
          '(lambda ()
             (setq fill-column 66)
             (setq *prefix-string* "> ")
             ))

(add-hook 'nxml-mode-hook
          '(lambda ()
             (defun flymake-xml-init ()
               (list "xmlstarlet" (list "val" (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))))
             ))

(add-hook 'text-mode-hook
          '(lambda ()
             (turn-on-auto-fill)
             (setq spell-filter nil)
             ))

(add-hook 'vc-log-mode-hook
          '(lambda ()
             (setq fill-column 66)
             ))

(setq auto-mode-alist
      (append '(
                ("\\.m$"   . matlab-mode)
                )
              auto-mode-alist))

;; ??? (setq auto-mode-alist
;; ???       (append '(
;; ???                 ("\\.h$"   . c++-mode)
;; ???                 ("\\.cc$"  . c++-mode)
;; ???                 ("\\.hh$"  . c++-mode)
;; ???                 ("\\.hpp$" . c++-mode)
;; ???                 ("\\.cpp$" . c++-mode)
;; ???                 ("\\.H$"   . c++-mode)
;; ???                 ("\\.C$"   . c++-mode)
;; ???                 ("\\.c$"   . c-mode)
;; ???                 ("\\.l$"   . c-mode)
;; ???                 ("\\.y$"   . c-mode)
;; ???                 ("\\.cnl$" . c-mode)
;; ???                 ("\\.dtd$" . dtd-mode)
;; ???                 ("\\.m$"   . matlab-mode)
;; ???                 ("\\.mdl$" . conf-mode)
;; ???                 ("\\.org$" . org-mode)
;; ???                 ("\\.py$"  . python-mode)
;; ???                 ("\\.php$" . php-mode)
;; ???                 ("\\.rst$" . rst-mode)
;; ???                 ("\\.asp$" . visual-basic-mode)
;; ???                 ("\\.vbs$" . visual-basic-mode)
;; ???                 ("\\.xml$" . nxml-mode)
;; ???                 )
;; ???               auto-mode-alist))
;; ???
;; ??? (or (assoc "\\.html$" auto-mode-alist)
;; ???     (setq auto-mode-alist (cons '("\\.html$" . html-mode)
;; ???                                 auto-mode-alist)))
