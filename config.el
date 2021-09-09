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
    ivy-rich-switch-buffer-name-max-length 50)
  (when IS-WINDOWS
    (setq counsel-rg-base-command `("rg" "-M" "1024" "--pcre2" "-H" "-n" "--color" "never" "--no-heading"
                                     "-S" "--hidden" "-L" "-P" "%s" ".")
      counsel-async-command-delay 0.2)))

     ;; (setq counsel-rg-base-command `("rg" "-M" "240" "--pcre2" "--with-filename" "--no-heading" "-S" "--line-number" "--color" "never" 
     ;;                    "-L" "-P" "%s"  "-H" "-n" "--path-separator" "//" ".")
     ;; counsel-async-command-delay 0.2)))
     
    ;;(setq counsel-rg-base-command "rg -M 240 --with-filename --no-heading --line-number --color never %s --path-separator // ."
     ;; ivy-dynamic-exhibit-delay-ms 100
     ;;counsel-async-command-delay 0.5
    ;; )))

;; **** projectile
(after! projectile
  (when (and IS-WINDOWS (executable-find doom-projectile-fd-binary))
    (setq projectile-generic-command
          (format "%s . -0 -H -E .git --color=never --type file --type symlink --follow  --path-separator=//"
                  doom-projectile-fd-binary))))

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
;; **** format-all
(use-package! format-all)
;; **** protobuf-mode
(use-package! protobuf-mode)
;; **** interleave
(use-package! interleave)
;; input method
(use-package! rime
  :custom
  (default-input-method "rime"))

;;; Code:
(setq rime-user-data-dir "~/.config/fcitx/rime")

(setq rime-posframe-properties
      (list :background-color "#333333"
            :foreground-color "#dcdccc"
            :font "SF mono"
            :internal-border-width 10))

(setq default-input-method "rime"
      rime-show-candidate 'posframe)

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

(after! (vterm evil-collection)
  (add-hook!
   'vterm-mode-hook
   (evil-collection-define-key '(normal insert) 'vterm-mode-map
     (kbd "C-\\") 'toggle-input-method)))

(after! yasnippet
  (add-to-list 'yas-snippet-dirs 'private-file-templates-dir 'append #'eq)
  (set-file-template! "/main\\.c\\(?:c\\|pp\\)$" :trigger "__paruka_main.cpp" :mode 'c++-mode)
  (set-file-template! "\\.h\\(?:h\\|pp\\|xx\\)$" :trigger "__paruka_hpp" :mode 'c++-mode)
  (set-file-template! "/CMakeLists.txt$" :trigger "__paruka_cmake.txt" :mode 'cmake-mode)
  (set-file-template! "/.clang_format$" :trigger "__paruka_clang_format" :mode 'Fundamental-mode)
  (set-file-template! "\\.org$" :trigger "__paruka_org.org" :mode 'org-mode)
  (yas-reload-all))

(add-hook 'python-mode-local-vars-hook
  (lambda ()
    (when (flycheck-may-enable-checker 'python-pylint)
      (flycheck-select-checker 'python-pylint))))

(setq-hook! 'python-mode-hook +format-with-lsp nil)

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
  (let ((docx-file (concat (file-name-sans-extension (buffer-name)) ".docx"))
         (template-file "~/.doom.d/org/docs/templates/template_me.docx")
         (docx-dir "~/.doom.d/org/docs/"))
    (shell-command (format "pandoc %s -o %s%s --reference-doc=%s" (buffer-file-name) docx-dir docx-file template-file))
    (message "Convert finish: %s" docx-file)))

;; * UI
(setq browse-url-browser-function 'xwidget-webkit-browse-url
      display-line-numbers-type nil
      ;;doom-big-font (font-spec :family "SF Mono" :size 18)
      ;;doom-font (font-spec :family "Source Code Pro" :size 16)
      doom-theme 'doom-city-lights ;;'doom-nord
      ;;doom-unicode-font (font-spec :family "Sarasa Mono SC" :size 14)
      ;;doom-variable-pitch-font (font-spec :family "SF Compact Display" :size 13)
      frame-alpha-lower-limit 0
      frame-title-format
      '("emacs%@"
        (:eval (system-name)) ": "
        (:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name)) "%b")))
      indicate-buffer-boundaries nil
      indicate-empty-lines nil
      org-bullets-bullet-list '("◉")
      pdf-view-use-unicode-ligther nil
      which-key-idle-delay 0.3
      display-line-numbers-type 'relative
      user-full-name "Paruka"
      user-mail-address "paruka.me@gmail.com"
      epa-file-encrypt-to user-mail-address
      doom-leader-alt-key "C-;")

;; **** Frames/Windows
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(or standard-display-table
    (setq standard-display-table (make-display-table)))
(set-display-table-slot standard-display-table 0 ?\ )
(setq-default fringe-indicator-alist
              (delq (assq 'truncation fringe-indicator-alist)
                    (delq (assq 'continuation fringe-indicator-alist)
                          fringe-indicator-alist)))

;; * Mac-specific
(when IS-MAC
  (setq insert-directory-program "gls"
        ns-use-thin-smoothing t
        exec-path (append '("/usr/local/bin" "~/go/bin" "~/Documents/develop/flutter/bin/" "~/.cargo/bin") exec-path)
        doom-font (font-spec :family "Menlo" :size 16)
        ;;counsel-rg-base-command "rg -M 120 --pcre2 --with-filename --no-heading --line-number --color never %s --path-separator \\\\ \."
        ;;ccls-executable (concat doom-private-dir "bin/ccls.osx")
        lsp-prefer-flymake nil
        flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  (setq ccls-initialization-options
        `(:clang ,(list :extraArgs ["-isystem/Library/Developer/CommandLineTools/usr/include/c++/v1"
                                    "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include"
                                    "-isystem/usr/local/include"]
                        :resourceDir (string-trim (shell-command-to-string "clang -print-resource-dir")))))
        
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

;; * Arch-specific
(when IS-LINUX
  (setq insert-directory-program "ls"
        conda-anaconda-home "/home/yangjianjia/anaconda3"
        +python-conda-home "/home/yangjianjia/.conda"
        +modeline-height 48
        doom-big-font (font-spec :family "SF Mono" :size 24)
        doom-font (font-spec :family "SF mono" :size 16)
        doom-theme 'doom-city-lights ;;'doom-nord
        doom-unicode-font (font-spec :family "Sarasa Mono SC" :size 16)
        doom-variable-pitch-font (font-spec :family "SF Compact Display" :size 16)
        exec-path (append '("/home/yangjianjia/anaconda3/bin" "/home/yangjianjia/.local/bin") exec-path))
  (setq-default c-basic-offset 4)
  (setq-default tab-width 4)
  (define-coding-system-alias 'UTF-8 'utf-8)
  (define-coding-system-alias 'utf8 'utf-8))

;; * Windows-specific
(when IS-WINDOWS
  (setq insert-directory-program "ls"
    ;; doom-big-font (font-spec :family "JetBrains Mono" :size 24)
    ;; doom-font (font-spec :family "JetBrains Mono" :size 16)
    ;; doom-unicode-font (font-spec :family "JetBrains Mono" :size 16)
    doom-big-font (font-spec :family "Mononoki Nerd Font" :size 24)
    doom-font (font-spec :family "Mononoki Nerd Font" :size 16)
    doom-unicode-font (font-spec :family "Mononoki Nerd Font" :size 16)
    ;; doom-big-font (font-spec :family "Source Code Pro" :size 24)
    ;; doom-font (font-spec :family "Source Code Pro" :size 16)
    ;; doom-unicode-font (font-spec :family "Source Han Sans" :size 16)
    doom-variable-pitch-font (font-spec :family "Source Code Pro")
    exec-path (append '("C:/home/Softwares/msys64/mingw64/bin"
                         "C:/home/Softwares/msys64/msys64/usr/local/bin"
                         "C:/home/Softwares/msys64/usr/bin"
                         "D:/Softwares/nodejs"
                         "C:/Users/yangjianjia/AppData/Roaming/npm") exec-path)
    ccls-executable "C:/home/Softwares/ccls/Release/ccls.exe")
  (setq ccls-initialization-options
    `(:clang ,(list :extraArgs ["-i/mingw64/include/c++/10.2.0"
                                 "-i/mingw64/include"
                                 "-i/usr/include"]
                :resourceDir (string-trim (shell-command-to-string "clang -print-resource-dir")))))
  (setq-default c-basic-offset 4)
  (setq-default tab-width 4)
  (define-coding-system-alias 'UTF-8 'utf-8)
  (define-coding-system-alias 'utf8 'utf-8))

;; * Keys
(setq
 doom-localleader-key ","
 +default-repeat-forward-key ";"
 +default-repeat-backward-key "'"
 evil-want-C-u-scroll t
 evil-want-integration t
 evil-shift-width 2
 evil-snipe-override-evil-repeat-keys nil
 evil-collection-company-use-tng nil
 evil-respect-visual-line-mode t
 +magit-hub-features t
 +evil-collection-disabled-list '(elfeed notmuch kotlin-mode simple dired helm ivy anaconda-mode outline))

;; * Hacks
(use-package-hook! ivy-rich
  :pre-init nil
  :pre-config nil)

(load! "+bindings")
