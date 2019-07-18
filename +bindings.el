;;; +bindings.el -*- lexical-binding: t; -*-
;;; key bindings
(map!
   :i "C-f" #'forward-char
   :i "C-x s" #'save-buffer
   :i "C-p" #'evil-previous-line
   :i "C-n" #'evil-next-line
   :i "C-b" #'backward-char)

 ;; (map!
 ;;  (:map override
 ;;    "C-f" #'forward-char
 ;;    "C-x s" #'save-buffer))
