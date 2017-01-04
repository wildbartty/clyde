(defpackage clyde-common
  (:use #:moira
	#:cl-string-match
	#:cl-string-complete	
	#:colorize
	#:shellpool
	#:common-lisp-user))

(defpackage clyde-listener
  (:use #:clyde-common
	#:cl-ncurses))


(defpackage clyde
  (:use #:clyde-common
	#:ltk)
  (:export :fact))

