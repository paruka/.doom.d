;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq request-storage-directory (concat doom-etc-dir "request/")
      trash-directory "~/.Trash/"
      delete-by-moving-to-trash t
      enable-remote-dir-locals t
      electric-pair-inhibit-predicate 'ignore
      persp-interactive-init-frame-behaviour-override -1
      org-directory "~/git/org")

;; **** ivy-config
(after! ivy
  (setq ivy-use-selectable-prompt t
        ivy-auto-select-single-candidate t
        ivy-rich-parse-remote-buffer nil
        +ivy-buffer-icons nil
        ivy-use-virtual-buffers nil
        ivy-magic-slash-non-match-action 'ivy-magic-slash-non-match-cd-selected
        ivy-height 20
        ivy-rich-switch-buffer-name-max-length 50))

;; **** avy
(after! avy
  (setq avy-all-windows 'all-frames))

;; **** evil
(after! evil
  (setq evil-escape-key-sequence "kj"))

;; **** ace-window
(after! ace-window
  (setq aw-keys '(?f ?d ?s ?r ?e ?w)
        aw-scope 'frame
        aw-ignore-current t
        aw-background nil))

;; **** flycheck
(after! flycheck
  (setq flycheck-checker-error-threshold 3000))

;; **** lua
(add-hook! lua-mode
  (global-flycheck-mode -1))

;; **** mwim
(use-package! mwim)

;; **** evil-lion
(use-package! evil-lion
  :config
  (evil-lion-mode))

;; **** sed
(use-package! sed-mode
  :commands (sed-mode))

;; **** deadgrep
(use-package! deadgrep
  :commands (deadgrep))

;; **** anki-editor
(use-package! anki-editor)

;; **** dart-mode!
(use-package! dart-mode
  ;;:hook ((dart-mode-hook . lsp))
  :config
  (setq dart-format-on-save t)
  (setq lsp-auto-guess-root t))

(after! dart-mode
  (add-hook 'dart-mode-hook #'lsp)
  (add-hook 'dart-mode-hook #'format-all-mode)
  (with-eval-after-load "projectile"
    (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
    (add-to-list 'projectile-project-root-files-bottom-up "BUILD")))

(after! org
  :config
  ;; (add-to-list 'org-latex-packages-alist
  ;;              '("" "tikz" t))
  ;; (eval-after-load "preview"
  ;; '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))
  ;;(setq org-latex-create-formula-image-program 'imagemagick)
  (setq org-preview-latex-default-process 'imagemagick)
  (setq org-latex-packages-alist
          '(("" "newpxtext,newpxmath" t)
            ("" "tikz" t)
            ("" "tikz-cd" t)
            ("" "eulervm" t)))
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.6))
  (with-eval-after-load "preview"
      (add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)))

(use-package! format-all)

(after! cc-mode
  (add-hook 'before-save-hook #'lsp-format-buffer))

;; **** magit
(after! magit
  (setq magit-blame--style
      '(margin
        (margin-format " %s%f" " %C %a" " %H")
        (margin-width . 42)
        (margin-face . magit-blame-margin)
        (margin-body-face magit-blame-dimmed))))

;; **** tools
(defun paruka/backward-kill-word-or-region (&optional arg)
  "Calls `kill-region' when a region is actived and
`backward-kill-word' otherwise. ARG is passed to
`backward-kill-word' if no region is active."
  (interactive "p")
  (if (region-active-p)
      ;; call interactively so kill-region handles rectangular selection correctly
      (call-interactively #'kill-region)
    (backward-kill-word arg)))

(use-package! org-noter
  :commands (org-noter)
  :config
  (after! pdf-tools
    (setq pdf-annot-activate-handler-functions #'org-noter-jump-to-note))
  (setq org-noter-notes-mode-map (make-sparse-keymap)))

(load! "+bindings")
