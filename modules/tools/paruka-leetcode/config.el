;;; tools/paruka-leetcode/config.el -*- lexical-binding: t; -*-

(defvar paruka/leetcode-directory
   (concat doom-private-dir "org/leetcode/")
   "The home path to a directory of leetcode files.")


(use-package! leetcode
  :config
  (setq leetcode-prefer-language "c++"
        leetcode-prefer-sql "mysql"
        leetcode-save-solutions t
        leetcode-directory paruka/leetcode-directory))
