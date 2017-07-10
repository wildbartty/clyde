(in-package :asdf)

;; A system to do fast fuzzy finding based on
;; input text

(defsystem clyde-finder
  :source-control "git"
  :author "Tom Lawlor <tominoz99@gmail.com>"
  :version "0.0.0"
  :license "mit"
  :serial t
  :depends-on ("cl-ppcre"
	       "mcclim")
  :components ((:file "package")
	       (:file "finder")))
