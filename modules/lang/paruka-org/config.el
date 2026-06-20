;;; lang/paruka-org/config.el -*- lexical-binding: t; -*-

(defvar paruka/org-home-dir
  (concat doom-user-dir "org/")
  "The home path to a directory of org files.")

(defvar paruka/hugo-org-dir
  (concat paruka/org-home-dir "blog/")
  "The path to a directory of hugo blog org files.")

(defvar paruka/org-agenda-dir
  (concat paruka/org-home-dir "gtd")
  "The path to directory of org files")

(setq org-directory paruka/org-agenda-dir)

(after! org-roam
  (require 'org-roam-protocol)
  (setq org-roam-directory (concat paruka/org-home-dir "roam"))
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+HUGO_SECTION: \n#+TITLE: ${title}\n#+filetags: \n#+ROAM_ALIAS:\n\n")
           :unnarrowed t)
          ("a" "api" plain "* 描述 \n\n%?\n* 声明\n\n* 注意\n"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+HUGO_SECTION: \n#+TITLE: ${title}\n#+filetags: \n#+ROAM_ALIAS:\n\n")
           :unnarrowed t)
          ("u" "ue4" plain "%?"
           :if-new (file+head "ue4/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+HUGO_SECTION: \n#+TITLE: ${title}\n#+filetags: ue4\n#+ROAM_ALIAS:\n\n")
           :unnarrowed t)
          ("g" "group")
          ("ga" "Group A" entry "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+HUGO_SECTION: \n#+TITLE: ${title}\n#+filetags: \n#+ROAM_ALIAS:\n\n")
           :unnarrowed t)
          ("gb" "Group B" entry "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+HUGO_SECTION: \n#+TITLE: ${title}\n#+filetags: \n#+ROAM_ALIAS:\n\n")
           :unnarrowed t)))
  ;; @see https://www.zmonster.me/2020/06/27/org-roam-introduction.html
  (setq org-roam-capture-ref-templates
        '(("r" "ref" entry "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+HUGO_SECTION: \n#+TITLE: ${title}\n#+ROAM_KEY: ${ref}\n")
           :unnarrowed t))))

(after! org
  ;; 确保 org 目录存在
  (dolist (dir (list paruka/org-home-dir paruka/org-agenda-dir
                     (concat paruka/org-home-dir "roam")
                     paruka/hugo-org-dir))
    (unless (file-exists-p dir)
      (make-directory dir t)))
  (setq org-agenda-files (list (expand-file-name "gtd/todo.org" paruka/org-home-dir)
                               (expand-file-name "gtd/done.org" paruka/org-home-dir)
                               (expand-file-name "gtd/notes.org" paruka/org-home-dir)))
  (setq org-preview-latex-default-process 'imagemagick)
  (dolist (pkg '(("" "newpxtext,newpxmath" t)
                 ("" "tikz" t)
                 ("" "tikz-cd" t)))
    (add-to-list 'org-latex-packages-alist pkg t))
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.6))
  (setq org-file-apps
        (append '(("\\.png\\'" . default)
                  ("\\.pdf\\'" . default))
                org-file-apps)))

(after! preview
  (add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))

;; Populates only the EXPORT_FILE_NAME property in the inserted headline.
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

(after! org-capture
  (add-to-list 'org-capture-templates
               '("h"                ;`org-capture' binding + h
                 "Hugo post"
                 entry
                 ;; It is assumed that below file is present in `org-directory'
                 ;; and that it has a "Blog Ideas" heading. It can even be a
                 ;; symlink pointing to the actual location of all-posts.org!
                 (file+olp ,(concat paruka/hugo-org-dir "all-posts.org") "Blog Ideas")
                 (function org-hugo-new-subtree-post-capture-template))))

(use-package! valign
  :hook (org-mode . valign-mode))
