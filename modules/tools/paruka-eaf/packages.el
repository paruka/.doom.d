;; -*- no-byte-compile: t; -*-
;;; tools/paruka-eaf/packages.el

(package! eaf
  :recipe (:host github
           :repo "emacs-eaf/emacs-application-framework"
           :branch "master"
           ;;:pre-build (("python3" "install-eaf.py" "--install" "pdf-viewer" "--ignore-sys-deps"))
           :files (
                   "*"
                   "core"
                   "extension"
                   "app"
                   ;; "*.el"
                   ;; "*.py"
                   ;; "*.json"
                   ;; "core"
                   ;; "app"
                   ;; "extension"
                   ;; "app/jupyter/*.el"
                   ;; "app/mermaid/*.el"
                   ;; "app/file-browser/*.el"
                   ;; "app/netease-clound-music/*.el"
                   ;; "app/markdown-previewer/*.el"
                   ;; "app/music-player/*.el"
                   ;; "app/video-player/*.el"
                   ;; "app/rss-reader/*.el"
                   ;; "app/airshare/*.el"
                   ;; "app/vue-demo/*.el"
                   ;; "app/terminal/*.el"
                   ;; "app/demo/*.el"
                   ;; "app/pdf-viewer/*.el"
                   ;; "app/image-viewer/*.el"
                   ;; "app/system-monitor/*.el"
                   ;; "app/mindmap/*.el"
                   ;; "app/file-sender/*.el"
                   ;; "app/org-previewer/*.el"
                   ;; "app/browser/*.el"
                   ;; "app/file-manager/*.el"
                   ;; "app/camera/*.el"
                   )))

