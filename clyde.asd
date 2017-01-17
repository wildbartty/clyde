
(defsystem clyde
	   :author "Tommy Lawlor"
	   :version "0.0.0"
	   :licence "MIT"
	   :depends-on ("ltk"
			"cl-fad"
			"alexandria"
			"cl-string-match"
			"colorize")
	   :serial t
	   :components ((:file "package")
			(:file "utils")
			(:file "sources")
			(:file "main")))
			
