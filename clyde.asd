(in-package :asdf)

(defsystem clyde
					 :description "clyde, a Common Lisp IDE"
					 :version "0.0.1"
					 :author "Thomas Lawlor <tominoz99@gmail.com>"
					 :licence "MIT"
					 :depends-on ("ltk" "cl-string-match"
												"cl-vectors" "osicat"
												"alexandria"
												"colorize"
												"uiop"
												"cl-string-complete")
					 :serial t
					 :components ((:file "gui")
												(:file "package")
												(:file "widgets")
												(:file "sources")
												(:file "main")))
