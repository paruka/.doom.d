;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq request-storage-directory (concat doom-data-dir "request/")
      delete-by-moving-to-trash t
      enable-remote-dir-locals t
      persp-interactive-init-frame-behaviour-override -1
      xref-prompt-for-identifier nil)

;; smartparens 已启用，禁用 electric-pair-mode 避免双重配对
(after! smartparens
  (electric-pair-mode -1))


;; **** projectile
(after! projectile
  (when (and (featurep :system 'windows) (executable-find doom-fd-executable))
    (setq projectile-generic-command
          (format "%s . -0 -H -E .git --color=never --type file --type symlink --follow --path-separator=//"
                  doom-fd-executable))))

;; **** avy
(after! avy
  (setq avy-all-windows 'all-frames))

;; **** evil-escape
(after! evil-escape
  (setq evil-escape-key-sequence "kj"))

;; **** ace-window
(after! ace-window
  (setq aw-keys '(?f ?d ?s ?r ?e ?w)
        aw-scope 'frame
        aw-ignore-current t
        aw-background nil))

;; **** mwim
(use-package! mwim
  :defer t)

;; **** evil-lion
(use-package! evil-lion
  :after evil
  :config
  (evil-lion-mode))

;; **** sed
(use-package! sed-mode
  :commands (sed-mode))

;; **** deadgrep
(use-package! deadgrep
  :commands (deadgrep))

;; **** anki-editor
(use-package! anki-editor
  :commands (anki-editor-mode anki-editor-push-notes anki-editor-insert-note))
;; **** protobuf-mode
(use-package! protobuf-mode
  :mode "\\.proto\\'")
;; input method
(when (featurep :system 'linux)
  (use-package! rime
    :defer t
    :custom
    (default-input-method "rime")
    (rime-user-data-dir "~/.config/fcitx/rime")
    (rime-show-candidate 'posframe)
    (rime-posframe-properties
     (list :background-color "#333333"
           :foreground-color "#dcdccc"
           :font "SF mono"
           :internal-border-width 10))))

;; **** magit
(after! magit
  (add-to-list 'magit-blame-styles
               '(my-margin
                 (margin-format " %s%f" " %C %a" " %H")
                 (margin-width . 42)
                 (margin-face . magit-blame-margin)
                 (margin-body-face magit-blame-dimmed)))
  (setq magit-blame-style 'my-margin))

;; private file templates
(defvar private-file-templates-dir
  (expand-file-name "templates/" (file-name-directory load-file-name))
  "The path to a directory of yasnippet folders to use for file templates.")

(after! (vterm evil-collection)
  (evil-collection-define-key '(normal insert) 'vterm-mode-map
    (kbd "C-\\") 'toggle-input-method))

(after! yasnippet
  (add-to-list 'yas-snippet-dirs private-file-templates-dir t #'eq))

;; lsp-proxy 接管 C/C++、Lua、Python 的格式化，禁止 Doom format 模块通过 LSP 格式化
(setq-hook! '(python-mode-hook python-ts-mode-hook
              c-mode-hook c++-mode-hook c-ts-mode-hook c++-ts-mode-hook
              lua-mode-hook lua-ts-mode-hook)
  +format-with-lsp nil)

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

(defun org-export-docx ()
  (interactive)
  (unless (executable-find "pandoc")
    (user-error "pandoc not found in PATH"))
  (unless (buffer-file-name)
    (user-error "Buffer is not visiting a file"))
  (let ((docx-file (concat (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) ".docx"))
        (template-file (expand-file-name "org/docs/templates/template_me.docx" doom-user-dir))
        (docx-dir (expand-file-name "org/docs/" doom-user-dir)))
    (shell-command (format "pandoc %s -o %s --reference-doc=%s"
                           (shell-quote-argument (buffer-file-name))
                           (shell-quote-argument (expand-file-name docx-file docx-dir))
                           (shell-quote-argument template-file)))
    (message "Convert finish: %s" docx-file)))

;; * UI
(setq browse-url-browser-function (if (featurep 'xwidget-internal)
                                      'xwidget-webkit-browse-url
                                    'browse-url-default-browser)
      doom-theme 'doom-city-lights
      frame-alpha-lower-limit 0
      frame-title-format
      '("emacs%@"
        (:eval (system-name)) ": "
        (:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name)) "%b")))
      indicate-buffer-boundaries nil
      indicate-empty-lines nil
      pdf-view-use-unicode-lighter nil
      which-key-idle-delay 0.3
      display-line-numbers-type 'relative
      user-full-name "Paruka"
      user-mail-address "paruka.me@gmail.com"
      epa-file-encrypt-to user-mail-address)

;; **** Frames/Windows
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(unless standard-display-table
  (setq standard-display-table (make-display-table)))
(set-display-table-slot standard-display-table 0 ?\ )
(setq-default fringe-indicator-alist
              (delq (assq 'truncation fringe-indicator-alist)
                    (delq (assq 'continuation fringe-indicator-alist)
                          fringe-indicator-alist)))

;; * Platform-specific
;; Common non-Mac defaults
(unless (featurep :system 'macos)
  (setq insert-directory-program "ls")
  (setq-default c-basic-offset 4
                tab-width 4)
  (define-coding-system-alias 'UTF-8 'utf-8)
  (define-coding-system-alias 'utf8 'utf-8))

(cond
 ((featurep :system 'macos)
  (setq insert-directory-program "gls"
        ns-use-thin-smoothing t
        trash-directory "~/.Trash/"
        exec-path (append (mapcar #'expand-file-name
                                  '("/usr/local/bin" "~/go/bin"
                                    "~/Documents/develop/flutter/bin/"
                                    "~/.cargo/bin"))
                          exec-path)
        doom-font (font-spec :family "Menlo" :size 16)
        doom-symbol-font (font-spec :family "Noto Sans Mono CJK SC" :size 16))
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

 ((featurep :system 'linux)
  (setq doom-modeline-height 48
        doom-big-font (font-spec :family "Mononoki Nerd Font" :size 24)
        doom-font (font-spec :family "Mononoki Nerd Font" :size 16)
        doom-symbol-font (font-spec :family "Mononoki Nerd Font" :size 16)
        doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 16)
        exec-path (append (list (expand-file-name "~/.local/bin")) exec-path))
  (setenv "PATH" (concat (expand-file-name "~/.local/bin") path-separator (getenv "PATH")))
  (prefer-coding-system 'utf-8)
  (set-coding-system-priority 'utf-8 'gb18030 'gbk 'gb2312 'latin-1)
  ;; 自动检测 UTF-8 或 GB18030：若文件不是合法 UTF-8，则用 GB18030 解码
  (defun my/auto-detect-gb18030 (size)
    (let* ((end (min (+ (point-min) size) (point-max)))
           (raw (buffer-substring-no-properties (point-min) end))
           (detected (detect-coding-string raw)))
      (unless (cl-some (lambda (c) (eq (coding-system-base c) 'utf-8)) detected)
        'gb18030)))
  (add-to-list 'auto-coding-functions #'my/auto-detect-gb18030))

 ((featurep :system 'windows)
  (setq doom-big-font (font-spec :family "Mononoki Nerd Font" :size 24)
        doom-font (font-spec :family "Mononoki Nerd Font" :size 16)
        doom-symbol-font (font-spec :family "Mononoki Nerd Font" :size 16)
        doom-variable-pitch-font (font-spec :family "Source Code Pro")
        exec-path (append '("C:/home/Softwares/msys64/mingw64/bin"
                            "C:/home/Softwares/msys64/msys64/usr/local/bin"
                            "C:/home/Softwares/msys64/usr/bin"
                            "D:/Softwares/nodejs")
                          (list (expand-file-name "~/AppData/Roaming/npm"))
                          exec-path))))

;; * Keys
(setq +evil-collection-disabled-list '(elfeed notmuch kotlin-mode simple dired helm ivy anaconda-mode outline))

(after! evil
  (setq evil-shift-width 2
        evil-respect-visual-line-mode t))

(after! evil-snipe
  (setq evil-snipe-override-evil-repeat-keys nil))

;; * Hacks
(use-package! keycast
  :commands (keycast-mode-line-mode keycast-header-line-mode keycast-log-mode)
  :config
  (custom-set-faces!
    '(keycast-command :inherit doom-modeline-debug :height 0.9)
    '(keycast-key :inherit custom-modified :height 1.1 :weight bold)))

(when (featurep :system 'linux)
  (use-package! gif-screencast
    :commands gif-screencast-mode
    :config
    (map! :map gif-screencast-mode-map
          :g "<f8>" #'gif-screencast-toggle-pause
          :g "<f9>" #'gif-screencast-stop)
    (setq gif-screencast-program "maim"
          gif-screencast-args '("--quality" "3")
          gif-screencast-optimize-args '("--batch" "--optimize=3" "--usecolormap=/tmp/doom-color-theme"))
    (defun gif-screencast-write-colormap ()
      (when (boundp 'doom-themes--colors)
        (f-write-text
         (replace-regexp-in-string
          "\n+" "\n"
          (mapconcat (lambda (c) (if (listp (cdr c))
                                     (cadr c))) doom-themes--colors "\n"))
         'utf-8
         "/tmp/doom-color-theme")))
    (when (boundp 'doom-themes--colors)
      (gif-screencast-write-colormap))
    (add-hook 'doom-load-theme-hook #'gif-screencast-write-colormap)))

;; writeroom-mode
(setq +zen-text-scale 0.8)
(defvar +zen-org-starhide t
  "The value `org-modern-hide-stars' is set to.")

(defvar-local +zen--original-org-indent-mode-p nil)

(defun +zen-prose-org-h ()
  "Reformat the current Org buffer appearance for prose."
  (when (eq major-mode 'org-mode)
    (setq-local display-line-numbers nil
                visual-fill-column-width 60
                org-adapt-indentation nil)
    (when (featurep 'org-modern)
      (setq-local org-modern-star '("🙘" "🙙" "🙚" "🙛")
                  org-modern-hide-stars +zen-org-starhide)
      (org-modern-mode -1)
      (org-modern-mode 1))
    (setq-local +zen--original-org-indent-mode-p org-indent-mode)
    (org-indent-mode -1)))

(defun +zen-nonprose-org-h ()
  "Reverse the effect of `+zen-prose-org'."
  (when (eq major-mode 'org-mode)
    (when (bound-and-true-p org-modern-mode)
      (org-modern-mode -1)
      (org-modern-mode 1))
    (when +zen--original-org-indent-mode-p (org-indent-mode 1))))

(after! writeroom-mode
  (dolist (var '(display-line-numbers
                 visual-fill-column-width
                 org-adapt-indentation
                 org-modern-mode
                 org-modern-star
                 org-modern-hide-stars))
    (add-to-list 'writeroom--local-variables var))
  (add-hook 'writeroom-mode-enable-hook #'+zen-prose-org-h)
  (add-hook 'writeroom-mode-disable-hook #'+zen-nonprose-org-h))

(use-package! meson-mode
  :mode "/meson\\.build\\'")

;; C/C++、Lua、Python 由 lsp-proxy 处理，不通过 eglot
(add-to-list 'auto-mode-alist '("\\.cppm\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.inl\\'" . c++-mode))

(after! cc-mode
  (map! :map c-mode-base-map
        :i [remap c-indent-line-or-region] #'completion-at-point))

(after! eglot
  (add-hook 'eglot-managed-mode-hook (lambda () (eldoc-box-hover-mode 1)) t)
  (add-hook 'eldoc-box-buffer-setup-hook #'eldoc-box-prettify-ts-errors)
  (advice-add 'jsonrpc--log-event :override #'ignore)
  ;; lsp-proxy 负责 C/C++、Lua、Python，阻止 eglot 在这些模式下启动
  (dolist (hook '(c-mode-hook c++-mode-hook c++-ts-mode-hook c-ts-mode-hook
                  lua-mode-hook lua-ts-mode-hook
                  python-mode-hook python-ts-mode-hook))
    (remove-hook hook #'+lsp-init-maybe-h)))

(use-package! eldoc-box
  :after (:any eglot lsp-proxy))

(after! eldoc-box
  (map! :leader
        :desc "Toggle eldoc-box hover" "t e" #'eldoc-box-hover-mode
        :desc "Close eldoc box frame"  "t x" #'eldoc-box-quit-frame))

(use-package! lsp-proxy
  :hook ((lua-ts-mode lua-mode
                      c-mode c-ts-mode c++-mode c++-ts-mode
                      python-mode python-ts-mode) . lsp-proxy-mode)
  :config
  (setq lsp-proxy-server-path (expand-file-name "emacs-lsp-proxy" doom-data-dir)
        lsp-proxy-enable-bytecode nil
        lsp-proxy-diagnostics-max-push-count 1000)
  (add-hook 'lsp-proxy-mode-hook
            (lambda ()
              (eldoc-box-hover-mode 1)
              (add-hook '+lookup-implementations-functions #'lsp-proxy-find-implementations nil t)
              (add-hook '+lookup-type-definition-functions #'lsp-proxy-find-type-definition nil t)
              (add-hook '+lookup-documentation-functions   #'lsp-proxy-describe-thing-at-point nil t))))

(after! dumb-jump
  (setq dumb-jump-force-searcher 'rg))

;; **** corfu
;; TUI 下降级为 consult-completion-in-region（daemon 模式兼容）
(defun +corfu--setup-tui-completion (&optional frame)
  (if (display-graphic-p frame)
      (setq-default completion-in-region-function #'completion--in-region)
    (setq-default completion-in-region-function #'consult-completion-in-region)))
(add-hook 'after-make-frame-functions #'+corfu--setup-tui-completion)
(+corfu--setup-tui-completion)

(after! corfu
  (setq corfu-cycle t
        corfu-auto t
        corfu-auto-prefix 2
        corfu-auto-delay 0.2
        corfu-quit-at-boundary nil
        corfu-scroll-margin 5
        corfu-max-width 100
        corfu-max-height 10
        corfu-popupinfo-delay '(0.2 . 0.1)
        corfu-popupinfo-direction 'auto)
  (add-hook 'corfu-mode-hook #'corfu-popupinfo-mode)
  (map! :map corfu-map
        "TAB"     #'corfu-next
        [tab]     #'corfu-next
        "S-TAB"   #'corfu-previous
        [backtab] #'corfu-previous
        "RET"     #'corfu-insert
        [return]  #'corfu-insert
        "M-d"     #'corfu-popupinfo-toggle
        "C-g"     #'corfu-quit
        "M-n"     #'corfu-popupinfo-scroll-up
        "M-p"     #'corfu-popupinfo-scroll-down)
  (defun +corfu--setup-terminal-mode (&optional frame)
    (if (display-graphic-p frame)
        (corfu-terminal-mode -1)
      (corfu-terminal-mode +1)))
  (add-hook 'after-make-frame-functions #'+corfu--setup-terminal-mode)
  (+corfu--setup-terminal-mode))

(setq completion-cycle-threshold 1
      tab-always-indent 'complete)


(load! "+bindings")
