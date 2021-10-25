;;; tools/paruka-eaf/config.el -*- lexical-binding: t; -*-


(defvar paruka/eaf-apps
  '(eaf
    eaf-jupyter
    eaf-mermaid
    eaf-file-browser
    eaf-netease-cloud-music
    eaf-markdown-previewer
    eaf-music-player
    eaf-video-player
    eaf-rss-reader
    eaf-airshare
    eaf-vue-demo
    eaf-terminal
    eaf-demo
    eaf-pdf-viewer
    eaf-image-viewer
    eaf-system-monitor
    eaf-mindmap
    eaf-file-sender
    eaf-org-previewer
    eaf-browser
    eaf-file-manager
    eaf-camera)
  "The home path to a directory of leetcode files.")

(use-package! eaf
  :custom
                                        ; See https://github.com/emacs-eaf/emacs-application-framework/wiki/Customization
  (eaf-browser-continue-where-left-off t)
  (eaf-browser-enable-adblocker t)
  (browse-url-browser-function 'eaf-open-browser)
  :init
  (progn
    (setq eaf-enable-debug t)
    (setq eaf-browser-keybinding
          '(("C--" . "zoom_out")
            ("C-=" . "zoom_in")
            ("C-0" . "zoom_reset")
            ("C-s" . "search_text_forward")
            ("C-r" . "search_text_backward")
            ("C-n" . "scroll_up")
            ("C-p" . "scroll_down")
            ("C-f" . "scroll_right")
            ("C-b" . "scroll_left")
            ("C-v" . "scroll_up_page")
            ("C-y" . "yank_text")
            ("C-w" . "kill_text")
            ("M-e" . "atomic_edit")
            ("M-c" . "caret_toggle_browsing")
            ("M-D" . "select_text")
            ("M-s" . "open_link")
            ("M-S" . "open_link_new_buffer")
            ("M-B" . "open_link_background_buffer")
            ("C-/" . "undo_action")
            ("M-_" . "redo_action")
            ("M-w" . "copy_text")
            ("M-f" . "history_forward")
            ("M-b" . "history_backward")
            ("M-q" . "clear_cookies")
            ("C-t" . "toggle_password_autofill")
            ("C-d" . "save_page_password")
            ("M-a" . "toggle_adblocker")
            ("C-M-q" . "clear_history")
            ("C-M-i" . "import_chrome_history")
            ("M-v" . "scroll_down_page")
            ("M-<" . "scroll_to_begin")
            ("M->" . "scroll_to_bottom")
            ("M-p" . "duplicate_page")
            ("M-t" . "new_blank_page")
            ("M-d" . "toggle_dark_mode")
            ("<" . "insert_or_select_left_tab")
            (">" . "insert_or_select_right_tab")
            ("j" . "insert_or_scroll_up")
            ("k" . "insert_or_scroll_down")
            ("h" . "insert_or_scroll_left")
            ("l" . "insert_or_scroll_right")
            ("f" . "insert_or_open_link")
            ("F" . "insert_or_open_link_new_buffer")
            ("B" . "insert_or_open_link_background_buffer")
            ("c" . "insert_or_caret_at_line")
            ("J" . "insert_or_scroll_up_page")
            ("K" . "insert_or_scroll_down_page")
            ("H" . "insert_or_history_backward")
            ("L" . "insert_or_history_forward")
            ("t" . "insert_or_new_blank_page")
            ("T" . "insert_or_recover_prev_close_page")
            ("i" . "insert_or_focus_input")
            ("I" . "insert_or_open_downloads_setting")
            ("r" . "insert_or_refresh_page")
            ("g" . "insert_or_scroll_to_begin")
            ("x" . "insert_or_close_buffer")
            ("G" . "insert_or_scroll_to_bottom")
            ("-" . "insert_or_zoom_out")
            ("=" . "insert_or_zoom_in")
            ("0" . "insert_or_zoom_reset")
            ;; ("d" . "insert_or_dark_mode")
            ("m" . "insert_or_save_as_bookmark")
            ("o" . "insert_or_open_browser")
            ;; ("y" . "insert_or_download_youtube_video")
            ("y" . "insert_or_copy_text")
            ("Y" . "insert_or_download_youtube_audio")
            ("p" . "insert_or_toggle_device")
            ("P" . "insert_or_duplicate_page")
            ("1" . "insert_or_save_as_pdf")
            ("2" . "insert_or_save_as_single_file")
            ("v" . "insert_or_view_source")
            ("e" . "insert_or_edit_url")
            ("C-M-c" . "copy_code")
            ("C-M-l" . "copy_link")
            ("C-a" . "select_all_or_input_text")
            ("M-u" . "clear_focus")
            ("C-j" . "open_downloads_setting")
            ("M-o" . "eval_js")
            ("M-O" . "eval_js_file")
            ("<escape>" . "eaf-browser-send-esc-or-exit-fullscreen")
            ("M-," . "eaf-send-down-key")
            ("M-." . "eaf-send-up-key")
            ("M-m" . "eaf-send-return-key")
            ("<f5>" . "refresh_page")
            ("<f12>" . "open_devtools")
            ("<C-return>" . "eaf-send-ctrl-return-sequence")))


    (setq eaf-pdf-viewer-keybinding
          '(("j" . "scroll_up")
            ("<down>" . "scroll_up")
            ("C-n" . "scroll_up")
            ("k" . "scroll_down")
            ("<up>" . "scroll_down")
            ("C-p" . "scroll_down")
            ("h" . "scroll_left")
            ("<left>" . "scroll_left")
            ("C-b" . "scroll_left")
            ("l" . "scroll_right")
            ("<right>" . "scroll_right")
            ("C-f" . "scroll_right")
            ("J" . "scroll_up_page")
            ("K" . "scroll_down_page")
            ("C-v" . "scroll_up_page")
            ("M-v" . "scroll_down_page")
            ("t" . "toggle_read_mode")
            ("0" . "zoom_reset")
            ("=" . "zoom_in")
            ("-" . "zoom_out")
            ("g" . "scroll_to_begin")
            ("G" . "scroll_to_end")
            ("p" . "jump_to_page")
            ("P" . "jump_to_percent")
            ("[" . "save_current_pos")
            ("]" . "jump_to_saved_pos")
            ("i" . "toggle_inverted_mode")
            ("m" . "toggle_mark_link")
            ("f" . "jump_to_link")
            ("d" . "toggle_inverted_mode")
            ("M-w" . "copy_select")
            ("C-s" . "search_text_forward")
            ("C-r" . "search_text_backward")
            ("x" . "close_buffer")
            ("C-<right>" . "rotate_clockwise")
            ("C-<left>" . "rotate_counterclockwise")
            ("M-h" . "add_annot_highlight")
            ("M-u" . "add_annot_underline")
            ("M-s" . "add_annot_squiggly")
            ("M-d" . "add_annot_strikeout_or_delete_annot")
            ("M-e" . "add_annot_text_or_edit_annot")
            ("M-p" . "toggle_presentation_mode")
            ("o" . "eaf-pdf-outline"))))
  :config
  (defalias 'browse-web #'eaf-open-browser)
  (dolist (app paruka/eaf-apps)
    (require app nil 'noerror))
  (setq browse-url-browser-function 'eaf-open-browser)
  (setq eaf-browser-enable-adblocker "true"))

;; (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
;; (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
;; (eaf-bind-key take_photo "p" eaf-camera-keybinding)
;; (eaf-bind-key nil "M-q" eaf-browser-keybinding)) ;; unbind, see more in the Wiki

;; (after! eaf
;;   :config
;;   (require 'eaf-jupyter)
;;   (require 'eaf-mermaid)
;;   (require 'eaf-file-browser)
;;   (require 'eaf-netease-cloud-music)
;;   (require 'eaf-markdown-previewer)
;;   (require 'eaf-music-player)
;;   (require 'eaf-video-player)
;;   (require 'eaf-rss-reader)
;;   (require 'eaf-airshare)
;;   (require 'eaf-vue-demo)
;;   (require 'eaf-terminal)
;;   (require 'eaf-demo)
;;   (require 'eaf-pdf-viewer)
;;   (require 'eaf-image-viewer)
;;   (require 'eaf-system-monitor)
;;   (require 'eaf-mindmap)
;;   (require 'eaf-file-sender)
;;   (require 'eaf-org-previewer)
;;   (require 'eaf-browser)
;;   (require 'eaf-file-manager)
;;   (require 'eaf-camera))
;; (after! eaf
;;   :config
;;   (require 'org-roam-protocol)
;;   (setq org-roam-directory (concat paruka/org-home-dir "roam")))
