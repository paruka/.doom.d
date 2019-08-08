;;; +bindings.el -*- lexical-binding: t; -*-
;;; key bindings
(map!
   :i "C-f" #'forward-char
   :i "C-x s" #'save-buffer
   :nvim "C-x C-f" #'counsel-find-file
   :vi "C-p" #'previous-line
   :vi "C-n" #'next-line
   :i "C-b" #'backward-char
   :i "C-r" #'isearch-backward
   :i "C-d" #'delete-char
   :nvim "C-e" #'mwim-end-of-line-or-code
   :nvim "C-a" #'mwim-beginning-of-code-or-line
   :nvim "C-k" #'kill-line
   :nvim "C-@" #'set-mark-command
   :nvim "C-SPC" #'set-mark-command
   :i "C-y" #'yank
   ;:i "M-y" #'yank-pop
   :i "C-v" #'scroll-up-command
   :i "M-v" #'scroll-down-command
   :nvim "C-w" #'paruka/backward-kill-word-or-region)

(map! :leader
      (:prefix-map ("j" . "jump")
        :desc "evil-avy-goto-char" "j" #'evil-avy-goto-char
        :desc "evil-avy-goto-char2" "J" #'evil-avy-goto-char-2
        :desc "evil-avy-goto-line" "l" #'evil-avy-goto-line
        :desc "evil-avy-goto-word-0" "W" #'evil-avy-goto-word-0
        :desc "evil-avy-goto-word-1" "w" #'evil-avy-goto-word-1))
