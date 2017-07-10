(in-package :asdf)

;; A package to do fast fuzzy finding based on
;; input text

(defsystem clyde-finder
  :source-control "git"
  :author "Tom Lawlor <tominoz99@gmail.com>"
  :version "0.0.0"
  :license "mit"
  :serial t
  :depends-on ("cl-ppcre")
  :components ((:file "package")
	       (:file "finder")))