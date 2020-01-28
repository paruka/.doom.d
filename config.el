;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq request-storage-directory (concat doom-etc-dir "request/")
      trash-directory "~/.Trash/"
      delete-by-moving-to-trash t
      enable-remote-dir-locals t
      electric-pair-inhibit-predicate 'ignore
      persp-interactive-init-frame-behaviour-override -1
      org-directory "~/git/org")

;; **** ivy-config
(after! ivy
  (setq ivy-use-selectable-prompt t
        ivy-auto-select-single-candidate t
        ivy-rich-parse-remote-buffer nil
        +ivy-buffer-icons nil
        ivy-use-virtual-buffers nil
        ivy-magic-slash-non-match-action 'ivy-magic-slash-non-match-cd-selected
        ivy-height 20
        ivy-rich-switch-buffer-name-max-length 50))

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

;; **** dart-mode!
(use-package! dart-mode
  ;;:hook ((dart-mode-hook . lsp))
  :config
  (setq dart-format-on-save t)
  (setq lsp-auto-guess-root t))

(after! dart-mode
  (add-hook 'dart-mode-hook #'lsp)
  (add-hook 'dart-mode-hook #'format-all-mode)
  (with-eval-after-load "projectile"
    (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
    (add-to-list 'projectile-project-root-files-bottom-up "BUILD")))

(after! org-mode
  :config
  ;; (add-to-list 'org-latex-packages-alist
  ;;              '("" "tikz" t))
  ;; (eval-after-load "preview"
  ;; '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))
  (setq org-latex-create-formula-image-program 'imagemagick))

(use-package! format-all)

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

;; *** pdf-tools
(after! pdf-view
  (setq pdf-view-use-scaling t
        pdf-view-use-imagemagick nil)
  (defun pdf-view-use-scaling-p ()
    "Return t if scaling should be used."
    (and (or (and (eq (framep-on-display) 'ns) (string-equal emacs-version "27.0.50"))
             (memq (pdf-view-image-type)
                   '(imagemagick image-io)))
         pdf-view-use-scaling))
  (defun pdf-annot-show-annotation (a &optional highlight-p window)
    "Make annotation A visible.
Turn to A's page in WINDOW, and scroll it if necessary.
If HIGHLIGHT-P is non-nil, visually distinguish annotation A from
other annotations."

    (save-selected-window
      (when window (select-window window))
      (pdf-util-assert-pdf-window)
      (let* ((page (pdf-annot-get a 'page))
             (size (pdf-view-image-size))
             (width (car size)))
        (unless (= page (pdf-view-current-page))
          (pdf-view-goto-page page))
        (let ((edges (pdf-annot-get-display-edges a)))
          (when highlight-p
            (pdf-view-display-image
             (pdf-view-create-image
                 (pdf-cache-renderpage-highlight
                  page width
                  `("white" "steel blue" 0.35 ,@edges))
               :map (pdf-view-apply-hotspot-functions
                     window page size)
               :width width)))
          (pdf-util-scroll-to-edges
           (pdf-util-scale-relative-to-pixel (car edges)))))))
  (defun pdf-isearch-hl-matches (current matches &optional occur-hack-p)
    "Highlighting edges CURRENT and MATCHES."
    (cl-check-type current pdf-isearch-match)
    (cl-check-type matches (list-of pdf-isearch-match))
    (cl-destructuring-bind (fg1 bg1 fg2 bg2)
        (pdf-isearch-current-colors)
      (let* ((width (car (pdf-view-image-size)))
             (page (pdf-view-current-page))
             (window (selected-window))
             (buffer (current-buffer))
             (tick (cl-incf pdf-isearch--hl-matches-tick))
             (pdf-info-asynchronous
              (lambda (status data)
                (when (and (null status)
                           (eq tick pdf-isearch--hl-matches-tick)
                           (buffer-live-p buffer)
                           (window-live-p window)
                           (eq (window-buffer window)
                               buffer))
                  (with-selected-window window
                    (when (and (derived-mode-p 'pdf-view-mode)
                               (or isearch-mode
                                   occur-hack-p)
                               (eq page (pdf-view-current-page)))
                      (pdf-view-display-image
                       (pdf-view-create-image data
                         :width width))))))))
        (pdf-info-renderpage-text-regions
         page width t nil
         `(,fg1 ,bg1 ,@(pdf-util-scale-pixel-to-relative
                        current))
         `(,fg2 ,bg2 ,@(pdf-util-scale-pixel-to-relative
                        (apply 'append
                               (remove current matches))))))))
  (defun pdf-util-frame-scale-factor ()
    "Return the frame scale factor depending on the image type used for display.
When `pdf-view-use-scaling' is non-nil and imagemagick or
image-io are used as the image type for display, return the
backing-scale-factor of the frame if available. If a
backing-scale-factor attribute isn't available, return 2 if the
frame's PPI is larger than 180. Otherwise, return 1."
    (if (and pdf-view-use-scaling
             (memq (pdf-view-image-type) '(imagemagick image-io))
             (fboundp 'frame-monitor-attributes))
        (or (cdr (assq 'backing-scale-factor (frame-monitor-attributes)))
            (if (>= (pdf-util-frame-ppi) 180)
                2
              1))
      (if (and (eq (framep-on-display) 'ns) (string-equal emacs-version "27.0.50"))
          2
        1)))
  (defun pdf-view-display-region (&optional region rectangle-p)
    ;; TODO: write documentation!
    (unless region
      (pdf-view-assert-active-region)
      (setq region pdf-view-active-region))
    (let ((colors (pdf-util-face-colors
                   (if rectangle-p 'pdf-view-rectangle 'pdf-view-region)
                   (bound-and-true-p pdf-view-dark-minor-mode)))
          (page (pdf-view-current-page))
          (width (car (pdf-view-image-size))))
      (pdf-view-display-image
       (pdf-view-create-image
           (if rectangle-p
               (pdf-info-renderpage-highlight
                page width nil
                `(,(car colors) ,(cdr colors) 0.35 ,@region))
             (pdf-info-renderpage-text-regions
              page width nil nil
              `(,(car colors) ,(cdr colors) ,@region)))
         :width width))))

  (advice-add 'pdf-view-mouse-set-region :override #'*pdf-view-mouse-set-region))

(use-package! org-noter
  :commands (org-noter)
  :config
  (after! pdf-tools
    (setq pdf-annot-activate-handler-functions #'org-noter-jump-to-note))
  (setq org-noter-notes-mode-map (make-sparse-keymap)))

(load! "+bindings")
