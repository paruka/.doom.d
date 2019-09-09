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
   :nvim "C-w" #'paruka/backward-kill-word-or-region
   (:after dired
        :map dired-mode-map
        :n "q" #'quit-window
        :n "v" #'evil-visual-char
        :nv "j" #'dired-next-line
        :nv "k" #'dired-previous-line
        :n "h" #'dired-up-directory
        :n "l" #'dired-find-file
        :n "#" #'dired-flag-auto-save-files
        :n "." #'evil-repeat
        :n "~" #'dired-flag-backup-files
        ;; Comparison commands
        :n "=" #'dired-diff
        :n "|" #'dired-compare-directories
        ;; move to marked files
        :m "[m" #'dired-prev-marked-file
        :m "]m" #'dired-next-marked-file
        :m "[d" #'dired-prev-dirline
        :m "]d" #'dired-next-dirline
        ;; Lower keys for commands not operating on all the marked files
        :desc "wdired" :n "w" #'wdired-change-to-wdired-mode
        :n "a" #'dired-find-alternate-file
        :nv "d" #'dired-flag-file-deletion
        :n "K" #'dired-do-kill-lines
        :n "r" #'dired-do-redisplay
        :nv "m" #'dired-mark
        :nv "t" #'dired-toggle-marks
        :nv "u" #'dired-unmark          ; also "*u"
        :nv "p" #'dired-unmark-backward
        ;; :n "W" #'browse-url-of-dired-file
        :n "x" #'dired-do-flagged-delete
        :n "y" #'dired-copy-filename-as-kill
        :n "Y" (lambda! (dired-copy-filename-as-kill 0))
        :n "+" #'dired-create-directory
        :n "O" #'dired-open-mac
        :n "o" #'dired-preview-mac
        ;; hiding
        :n "<tab>" #'dired-hide-subdir ;; FIXME: This can probably live on a better binding.
        :n "<backtab>" #'dired-hide-all
        :n "$" #'dired-hide-details-mode
        ;; misc
        :n "U" #'dired-undo
        ;; subtree
        )
   (:after org
     :map org-mode-map
     :localleader
     "C" #'org-copy-subtree))

(map! :leader
      (:prefix-map ("j" . "jump")
        :desc "evil-avy-goto-char" "j" #'evil-avy-goto-char
        :desc "evil-avy-goto-char2" "J" #'evil-avy-goto-char-2
        :desc "evil-avy-goto-line" "l" #'evil-avy-goto-line
        :desc "evil-avy-goto-word-0" "W" #'evil-avy-goto-word-0
        :desc "evil-avy-goto-word-1" "w" #'evil-avy-goto-word-1))
