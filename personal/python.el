;;; package --- ...
;;; Commentary:
;;; Code:

(require 'prelude-programming)

;; (prelude-ensure-module-deps '(epc auto-complete jedi virtualenv))
(prelude-ensure-module-deps '(epc auto-complete jedi))

(autoload 'python-mode "python" "Python Mode." t)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args ""
      python-shell-prompt-regexp "In \\[[0-9]+\\]: "
      python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
      python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
      python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
      python-shell-completion-string-code  "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
      )


;; Setup jedi (auto-completion)
;; (setq jedi:server-args
;;       (quote
;;        ("--sys-path"
;;         "/home/steinn/work/birdcore")))
;; (setq jedi:server-command
;;       (quote
;;        ("python2"
;;         "/home/steinn/.emacs.d/vendor/prelude/elpa/jedi-20130318.1248/jediepcserver.py"
;;         )))
;; (setq jedi:setup-keys t)
;; (autoload 'jedi:setup "jedi" nil t)

(defun prelude-python-mode-defaults ()
  "Python mode hook."
  (run-hooks 'prelude-prog-mode-hook)
  ;; (jedi:setup)
  (auto-complete-mode +1)
  (whitespace-mode +1)

  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (setq *prefix-string* "# ")

  ;; (virtualenv-minor-mode +1)
  (electric-indent-mode -1)
  (which-function-mode -1)
  )

(setq prelude-python-mode-hook 'prelude-python-mode-defaults)

(add-hook 'python-mode-hook (lambda ()
                              (run-hooks 'prelude-python-mode-hook)))

;; (add-hook 'python-mode-hook
;;           '(lambda ()
;;              (interactive)
;;              (run-hooks 'prelude-prog-mode-hook)
;;              (auto-complete-mode +1)
;;              (turn-on-font-lock)
;;              (setq tab-width 4)
;;              (setq indent-tabs-mode nil)
;;              (setq *prefix-string* "# ")
;;              (setq outline-regexp "def\\|class ")
;;              (set (make-variable-buffer-local 'beginning-of-defun-function)
;;                   'py-beginning-of-def-or-class)
;;              (setq py-python-command "python")
;;              (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;;
;;              (defun flymake-pyflakes-init ()
;;                (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                                   'flymake-create-temp-inplace))
;;                       (local-file (file-relative-name
;;                                    temp-file
;;                                    (file-name-directory buffer-file-name))))
;;                  (list "pyflakes" (list local-file))))
;;
;;              (add-to-list 'flymake-allowed-file-name-masks
;;                           '("\\.py\\'" flymake-pyflakes-init))
;;              ))


;;; python.el ends here
