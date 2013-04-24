;; my ibuffer overrides


(add-hook 'ibuffer-mode-hook
          (lambda ()
            (define-key ibuffer-mode-map (kbd "<SPC>") 'ibuffer-visit-buffer)
            ))
