;;; +bindings.el -*- lexical-binding: t; -*-
;;; key bindings
(map!
   :i "C-f" #'forward-char
   :i "C-x s" #'save-buffer
   :nvim "C-x C-f" #'counsel-find-file
   :i "C-p" #'evil-previous-line
   :i "C-n" #'evil-next-line
   :i "C-b" #'backward-char
   :i "C-r" #'isearch-backward
   :i "C-d" #'delete-char)

;; (map! :leader
;;       (:prefix-map ("s" . "search")
;;         :desc "swiper" "s" #'swiper))
