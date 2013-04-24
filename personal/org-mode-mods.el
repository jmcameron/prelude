;;; Org mode settings

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

(setq org-remember-templates
      (list
       (list "Todo" ?t "* TODO %^{Brief Description} %^g\n%?\n  Added: %U"
             (concat org-directory "new.org") "Tasks")
       ))

(defun org-agenda-switch-to-hide-rest ()
  (interactive)
  (org-agenda-switch-to t))
