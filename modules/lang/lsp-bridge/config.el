;;; lang/lsp-bridge/config.el -*- lexical-binding: t; -*-


(use-package! lsp-bridge
  :config
  (map! :map acm-mode-map
        [tab]           #'acm-select-next
        [backtab]       #'acm-select-prev)
  (map! :map doom-leader-code-map
        :desc "LSP Rename"
        "r"             #'lsp-bridge-rename
        :desc "LSP Find declaration"
        "j"             #'lsp-bridge-find-def
        (:prefix-map ("x" . "diagnostics")
         :desc "LSP List diagnostics"
         "l"             #'lsp-bridge-diagnostic-list
         :desc "LSP Jump next error"
         "]"  #'lsp-bridge-diagnostic-jump-next
         :desc "LSP Jump prev error"
         "[" #'lsp-bridge-diagnostic-jump-prev))

  (setq lsp-bridge-c-lsp-server "clangd")
  (setq flycheck-global-modes '())
  (setq lsp-bridge-enable-hover-diagnostic t)
  ;;(setq lsp-bridge-enable-auto-format-code t)
  ;;(setq lsp-bridge-signature-show-function 'lsp-bridge-signature-posframe)
  (require 'yasnippet)
  (yas-global-mode 1)
  (global-lsp-bridge-mode)
  (unless (display-graphic-p)
    (with-eval-after-load 'acm
      (require 'acm-terminal))))

(after! lsp-bridge
  (setq lsp-bridge-user-multiserver-dir (concat doom-user-dir "modules/lang/lsp-bridge/multiservers/")
        lsp-bridge-python-multi-lsp-server "paruka-pyright-ruff"))

(after! cc-mode
  (setq lsp-bridge-completion-hide-characters '(";" "(" ")" "[" "]" "{" "}" ", " "\"")))
