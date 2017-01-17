(defpackage clyde
  (:use #:cl
	#:ltk
	#:alexandria
	#:cl-string-match
	#:colorize)
  (:export :main
	   :get-lambda-list
	   :get-declared-types))
	
