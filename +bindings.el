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
   :i "C-d" #'delete-char
   :nvim "C-e" #'end-of-line
   :nvim "C-k" #'kill-line
   :nvim "C-@" #'set-mark-command
   :nvim "C-SPC" #'set-mark-command
   :i "C-y" #'yank)
  ;; :i "M-" #'yank-pop)

(map! :leader
      (:prefix-map ("j" . "jump")
        :desc "evil-avy-goto-char" "j" #'evil-avy-goto-char
        :desc "evil-avy-goto-char2" "J" #'evil-avy-goto-char-2
        :desc "evil-avy-goto-line" "l" #'evil-avy-goto-line
        :desc "evil-avy-goto-word-0" "W" #'evil-avy-goto-word-0
        :desc "evil-avy-goto-word-1" "w" #'evil-avy-goto-word-1))
