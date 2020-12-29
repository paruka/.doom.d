;;; init.el -*- lexical-binding: t; -*-

;; Copy this file to ~/.doom.d/init.el or ~/.config/doom/init.el ('doom
;; quickstart' will do this for you). The `doom!' block below controls what
;; modules are enabled and in what order they will be loaded. Remember to run
;; 'doom refresh' after modifying it.
;;
;; More information about these modules (and what flags they support) can be
;; found in modules/README.org.

(doom! :input
       chinese
       ;;japanese
       ;;layout          ; auie,ctsrnm is the superior home row

       :completion
       company           ; the ultimate code completion backend
       ;;helm            ; the *other* search engine for love and life
       ;;ido             ; the other *other* search engine...
       ivy               ; a search engine for love and life

       :ui
       deft              ; notational velocity for Emacs
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       (emoji +unicode)  ; 🙂
       ;;fill-column     ; a `fill-column' indicator
       hl-todo           ; highlight TODO/FIXME/NOTE tags
       ;;hydra
       ;;indent-guides   ; highlighted indent columns
       ;;ligatures       ; ligatures and symbols to make your code pretty again
       ;;minimap         ; show a map of the code on the side
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink the current line after jumping
       ;;neotree         ; a project drawer, like NERDTree for vim
       ophints           ; highlight the region an operation acts on
       (popup            ; tame sudden yet inevitable temporary windows
        +all             ; catch all popups that start with an asterix
        +defaults)       ; default popup rules
       ;;tabs            ; a tab bar for Emacs
       treemacs          ; a project drawer, like neotree but cooler
       unicode           ; extended unicode support for various languages
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows
       workspaces        ; tab emulation, persistence & separate workspaces
       ;;zen             ; distraction-free coding or writing

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       format
       ;;(format +onsave); automated prettiness
       ;;god             ; run Emacs commands without modifier keys
       ;;lispy           ; vim for lisp, for people who dont like vim
       multiple-cursors  ; editing in many places at once
       ;;objed           ; text object editing for the innocent
       ;;parinfer        ; turn lisp into python, sort of
       rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to
       ;;word-wrap       ; soft wrapping with language-aware indent

       :emacs
       (dired            ; making dired pretty [functional]
         ;;+ranger       ; bringing the goodness of ranger to dired
         +icons          ; colorful icons for dired-mode
       )
       electric          ; smarter, keyword-based electric-indent
       ;;ibuffer         ; interactive buffer management
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       ;;eshell            ; the elisp shell that works everywhere
       ;;shell             ; simple shell REPL for Emacs
       ;;term              ; basic terminal emulator for Emacs
       vterm               ; the best terminal emulation in Emacs

       :checkers
       syntax
       ;;spell             ; tasing you for misspelling mispelling
       ;;grammar           ; tasing grammar mistake every you make

       :tools
       ;;ansible
       ;;debugger          ; FIXME stepping through code, to help you add bugs
       ;;direnv
       docker
       editorconfig        ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)     ; run code, run (also, repls)
       ;;gist              ; interacting with github gists
       (lookup             ; helps you navigate your code and documentation
         +dictionary
         +docsets)         ; ...or in Dash docsets locally
       lsp
       magit               ; a git porcelain for Emacs
       ;;make              ; run make tasks from Emacs
       ;;pass              ; password manager for nerds
       pdf                 ; pdf enhancements
       ;;prodigy           ; FIXME managing external services & code builders
       rgb                 ; creating color strings
       ;;taskrunner        ; taskrunner for all your projects
       ;;terraform         ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       upload              ; map local to remote projects via ssh/ftp

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS
       tty                 ; improve the terminal Emacs experience

       :lang
       ;;agda              ; types of types of types of types...
       (cc                 ; C/C++/Obj-C madness
        +lsp)
       ;;clojure           ; java with a lisp
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       crystal             ; ruby at the speed of c
       (csharp +lsp)       ; unity, .NET, and mono shenanigans
       data                ; config/data formats
       (dart               ; paint ui and not much else
         +lsp
         +flutter)
       ;;elixir            ; erlang done right
       ;;elm               ; care for a cup of TEA?
       emacs-lisp          ; drown in parentheses
       ;;erlang            ; an elegant language for a more civilized age
       ;;ess               ; emacs speaks statistics
       ;;faust             ; dsp, but you get to keep your soul
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;fstar             ; (dependent) types and (monadic) effects and Z3
       ;;gdscript          ; the language you waited for
       (go                 ; the hipster dialect
         +lsp)
       ;;(haskell +intero) ; a language that's lazier than I am
       ;;hy                ; readability of scheme w/ speed of python
       ;;idris             ;
       json                ; At least it ain't XML
       (java +meghanada)   ; the poster child for carpal tunnel syndrome
       (javascript +lsp)   ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia             ; a better, faster MATLAB
       ;;kotlin            ; a better, slicker Java(Script)
       latex               ; writing papers in Emacs has never been so fun
       ;;lean
       ;;factor
       ;;ledger            ; an accounting system in Emacs
       (lua +moonscript)   ; one-based indices? one-based indices
       (markdown +grip)    ; writing docs for people to ignore
       nim                 ; python + lisp at the speed of c
       ;;nix               ; I hereby declare "nix geht mehr!"
       ;;ocaml             ; an objective camel
       (org                ; organize your plain life in plain text
        +attach            ; custom attachment system
        +babel             ; running code in org
        +capture           ; org-capture in and outside of Emacs
        +export            ; Exporting org to whatever you want
        +habit             ; Keep track of your habits
        +present           ; Emacs for presentations
        +protocol          ; Support for org-protocol:// links
        +roam              ; org roam
        +noter
        +pomodoro
        +pdf
        +dragndrop
        +gnuplot
        +present
        +hugo)
       ;;php               ; perl's insecure younger brother
       plantuml            ; diagrams for confusing people more
       ;;purescript        ; javascript, but functional
       (python             ; beautiful is better than ugly
         +lsp
         +pyright
         +cpython)
       ;;qt                ; the 'cutest' gui framework ever
       ;;racket            ; a DSL for DSLs
       ;;raku              ; the artist formerly known as perl6
       ;;rest              ; Emacs as a REST client
       ;;(ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (rust +lsp)         ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala             ; java, but good
       ;;scheme            ; a fully conniving family of lisps
       sh                  ; she sells (ba|z|fi)sh shells on the C xor
       ;;sml
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       ;;terra             ; Earth and Moon in alignment for performance.
       web                 ; the tubes
       yaml                ; JSON, but readable

       paruka-org

       :email
       ;;(mu4e +gmail)       ; WIP
       ;;notmuch             ; WIP
       ;;(wanderlust +gmail) ; WIP

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
       ;;calendar
       ;;irc               ; how neckbeards socialize
       ;;rss +org          ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought

       :collab
       ;;floobits          ; peer programming for a price
       ;;impatient-mode    ; show off code over HTTP

       :config
       ;; For literate config users. This will tangle+compile a config.org
       ;; literate config in your `doom-private-dir' whenever it changes.
       ;;literate
       ;;:private
       ;;paruka-org
       ;;paruka-cc

       ;; The default module sets reasonable defaults for Emacs. It also
       ;; provides a Spacemacs-inspired keybinding scheme and a smartparens
       ;; config. Use it as a reference for your own modules.
       (default +bindings +smartparens))

;; * UI
(setq browse-url-browser-function 'xwidget-webkit-browse-url
      display-line-numbers-type nil
      ;;doom-big-font (font-spec :family "SF Mono" :size 18)
      ;;doom-font (font-spec :family "Source Code Pro" :size 16)
      doom-theme 'doom-city-lights;;'doom-nord
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
        conda-anaconda-home "/opt/miniconda3"
        +python-conda-home "/home/paruka/.conda"
        +modeline-height 48
        doom-big-font (font-spec :family "SF Mono" :size 24)
        doom-font (font-spec :family "SF mono" :size 24)
        doom-theme 'doom-city-lights;;'doom-nord
        doom-unicode-font (font-spec :family "Sarasa Mono SC" :size 24)
        doom-variable-pitch-font (font-spec :family "SF Compact Display" :size 26)))

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

;; * Repo
(setq package-archives '(("gnu" . "https://elpa.emacs-china.org/gnu/")
                         ("org" . "https://elpa.emacs-china.org/org/")
                         ("melpa" . "https://elpa.emacs-china.org/melpa/")))

;; * Hacks
(use-package-hook! ivy-rich
  :pre-init nil
  :pre-config nil)
