;; -*- no-byte-compile: t; -*-
;;; lang/lsp-bridge/packages.el

(package! yasnippet)
(package! lsp-bridge
  :recipe (:host github
           :repo "manateelazycat/lsp-bridge"
           :files (:defaults "*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
           :build (:not compile)))

(unless (display-graphic-p)
  (package! popon
    :recipe (:host nil :repo "https://codeberg.org/akib/emacs-popon.git"))
  (package! acm-terminal
    :recipe (:host github :repo "twlz0ne/acm-terminal")))

(package! lsp-mode :disable t :ignore t)
(package! company :disable t :ignore t)
