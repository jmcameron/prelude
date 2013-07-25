;;; package -- Org mode settings

;;; Commentary:

;;; Code:

;; Work/home differences
(if (string= (user-login-name) "jmc")
    (progn
      ;; Work
      (setq user-mail-address "Jonathan.M.Cameron@jpl.nasa.gov")
      (setq mail-from-style nil)
      (setq org-directory (concat home-base-dir "/ttd/"))
      (setq org-agenda-files (append (list "~/ttd/work.org"
                                           "~/ttd/calendar.org")
                                     (file-expand-wildcards "~/ttd/links/*.org")
                                     ))
      )
  (progn
    ;; Personal
    (setq org-directory (concat home-base-dir "/org/"))
    (setq org-agenda-files (list "~/org/personal.org"
                                 ))
    ))

(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-custom-commands
      '(
        ("d" "Daily Action List"
         ((agenda "" ((org-agenda-ndays 1)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)
                      ))))
        ))
(setq org-log-done t)
(setq org-hide-leading-stars t)
(setq org-return-follows-link t)

(setq org-archive-location "%s_done::")

(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

;; ??? (setq org-remember-templates
;; ???       (list
;; ???        (list "Todo" ?t "* TODO %^{Brief Description} %^g\n%?\n  Added: %U"
;; ???              (concat org-directory "new.org") "Tasks")
;; ???        ))

(defun org-agenda-switch-to-hide-rest ()
  (interactive)
  (org-agenda-switch-to t))


(add-hook 'org-mode-hook
          '(lambda ()
             (require 'vc-git)
             (setq indent-tabs-mode nil)
             (setq org-indent-indentation-per-level 4)
             (setq fill-column 90)
             (setq org-tags-column -100)
             (setq whitespace-line-column 94)
             (setq compile-command "git ")
             ))

(add-hook 'org-agenda-mode-hook
          '(lambda ()
             (define-key org-agenda-mode-map [return] 'org-agenda-switch-to-hide-rest)
             ))
