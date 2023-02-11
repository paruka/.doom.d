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
(package! format-all)
(package! protobuf-mode)
(package! interleave)
(package! rime)
(package! keycast)
(package! gif-screencast)
;;(package! company :disable t)

(package! anaconda-mode :disable t)

(package! lsp-bridge :recipe
  (:host github
   :repo "manateelazycat/lsp-bridge"
   :files ("*.el" "acm" "core" "langserver" "*.py")))

(package! meson-mode)
