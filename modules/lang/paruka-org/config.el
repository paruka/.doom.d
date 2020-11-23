;;; lang/paruka-org/config.el -*- lexical-binding: t; -*-

(defvar paruka/org-home-dir
   (concat doom-private-dir "org/")
   "The home path to a directory of org files.")

(defvar paruka/hugo-org-dir
  (concat paruka/org-home-dir "blog/")
  "The path to a directory of hugo blog org files.")

(defvar paruka/org-agenda-dir
  (concat paruka/org-home-dir "gtd")
  "The path to directory of org files")

(setq org-directory paruka/org-agenda-dir)

(after! org-roam
  :config
  (require 'org-roam-protocol)
  (setq org-roam-directory (concat paruka/org-home-dir "roam")))

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
    (add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))
  (setq org-file-apps
        (append '(
                  ("\\.png\\'" . default)
                  ("\\.pdf\\'" . default)
                  ) org-file-apps )))

;; Populates only the EXPORT_FILE_NAME property in the inserted headline.
(with-eval-after-load 'org-capture
  (defun org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post.
See `org-capture-templates' for more information."
    (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
           (fname (org-hugo-slug title)))
      (mapconcat #'identity
                 `(
                   ,(concat "* TODO " title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " fname)
                   ":END:"
                   "%?\n")          ;Place the cursor here finally
                 "\n")))

  (add-to-list 'org-capture-templates
               '("h"                ;`org-capture' binding + h
                 "Hugo post"
                 entry
                 ;; It is assumed that below file is present in `org-directory'
                 ;; and that it has a "Blog Ideas" heading. It can even be a
                 ;; symlink pointing to the actual location of all-posts.org!
                 (file+olp ,(concat paruka/hugo-org-dir "all-posts.org") "Blog Ideas")
                 (function org-hugo-new-subtree-post-capture-template))))

(use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-export-inline-images t
        org-roam-server-authenticate nil
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

(setq org-roam-capture-templates
      '(
        ("d" "default" plain (function org-roam-capture--get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+SETUPFILE: ./%<%Y%m%d%H%M%S>-${slug}.org\n#+HUGO_SECTION: \n#+TITLE: ${title}\n#+ROAM_TAGS: \n#+ROAM_ALIAS:\n\n")
        ("a" "api" plain (function org-roam-capture--get-point)
         "* 描述 \n\n%?\n* 声明\n\n* 注意\n"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+SETUPFILE: ./%<%Y%m%d%H%M%S>-${slug}.org\n#+HUGO_SECTION: \n#+TITLE: ${title}\n#+ROAM_TAGS: \n#+ROAM_ALIAS:\n\n"
         :unnarrowed t)
        ("g" "group")
        ("ga" "Group A" plain (function org-roam-capture--get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+SETUPFILE: ./%<%Y%m%d%H%M%S>-${slug}.org\n#+HUGO_SECTION: \n#+TITLE: ${title}\n#+ROAM_TAGS: \n#+ROAM_ALIAS:\n\n")
        ("gb" "Group B" plain (function org-roam-capture--get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+SETUPFILE: ./%<%Y%m%d%H%M%S>-${slug}.org\n#+HUGO_SECTION: \n#+TITLE: ${title}\n#+ROAM_TAGS: \n#+ROAM_ALIAS:\n\n")))

;; @see https://www.zmonster.me/2020/06/27/org-roam-introduction.html
(setq org-roam-capture-ref-templates
      '(("r" "ref" plain (function org-roam-capture--get-point)
         ""
         :file-name "${slug}"
         :head "#+SETUPFILE: ./%<%Y%m%d%H%M%S>-${slug}.org\n#+HUGO_SECTION: \n#+TITLE: ${title}\n#+ROAM_KEY: ${ref}\n"
         :unnarrowed t)))
