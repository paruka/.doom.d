(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("/home/yangjianjia/.doom.d/org/gtd/todo.org" "/home/yangjianjia/.doom.d/org/gtd/done.org" "/home/yangjianjia/.doom.d/org/gtd/notes.org"))
 '(safe-local-variable-values
   '((lsp-auto-guess-root . t)
     (lsp-pyright-stub-path . "./typings/")
     (lsp-pyright-stub-path . "/home/yangjianjia/Documents/typeshed/")
     (eval font-lock-add-keywords nil
      `((,(concat "("
                  (regexp-opt
                   '("sp-do-move-op" "sp-do-move-cl" "sp-do-put-op" "sp-do-put-cl" "sp-do-del-op" "sp-do-del-cl")
                   t)
                  "\\_>")
         1 'font-lock-variable-name-face)))
     (eval require 'org-roam-dev))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
