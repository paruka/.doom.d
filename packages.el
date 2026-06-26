;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! mwim)
(package! sed-mode)
(package! deadgrep)
(package! evil-lion)
(package! anki-editor)
(package! protobuf-mode)
(when (featurep :system 'linux)
  (package! rime)
  (package! gif-screencast))
(package! keycast)

(package! meson-mode)

(when (featurep :system 'windows)
  (disable-packages! tree-sitter tree-sitter-langs))

(package! eldoc-box)

(package! corfu-terminal)
(package! lsp-proxy :recipe
  (:host github
   :repo "jadestrong/lsp-proxy"
   :files ("*.el")))
