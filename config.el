;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq request-storage-directory (concat doom-etc-dir "request/")
      trash-directory "~/.Trash/"
      delete-by-moving-to-trash t
      enable-remote-dir-locals t
      electric-pair-inhibit-predicate 'ignore
      persp-interactive-init-frame-behaviour-override -1)

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

(use-package! format-all)

(use-package! protobuf-mode)

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

;; private file templates
(defvar private-file-templates-dir
   (expand-file-name "templates/" (file-name-directory load-file-name))
   "The path to a directory of yasnippet folders to use for file templates.")

(after! yasnippet
  (add-to-list 'yas-snippet-dirs 'private-file-templates-dir 'append #'eq)
  (set-file-template! "/main\\.c\\(?:c\\|pp\\)$" :trigger "__paruka_main.cpp" :mode 'c++-mode)
  (set-file-template! "\\.h\\(?:h\\|pp\\|xx\\)$" :trigger "__paruka_hpp" :mode 'c++-mode)
  (set-file-template! "/CMakeLists.txt$" :trigger "__paruka_cmake.txt" :mode 'cmake-mode)
  (set-file-template! "/.clang_format$" :trigger "__paruka_clang_format" :mode 'Fundamental-mode)
  (set-file-template! "\\.org$" :trigger "__paruka_org.org" :mode 'org-mode)
  (yas-reload-all))

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

(load! "+bindings")
