(unless (find-package 'clyde)
  (ql:quickload '(;ltk
		 moira colorize
		 alexandria
		 cl-ncurses ;shellpool
		 cl-string-match cl-string-complete
		 cl-cffi-gtk
		 city-hash cl-fad)))

(defun load-files (files &key &allow-other-keys)
  (when files (progn
		(load (car files))
		(load-files (cdr files)))))


(defpackage clyde
  (:use #:cl #:gtk 
	#:gdk #:gdk-pixbuf 
	#:gobject #:glib 
	#:gio #:pango 
	#:cairo #:common-lisp	
	#:moira #:alexandria
	;#:shellpool
	#:cl-string-match
	#:cl-string-complete
	#:colorize
;	#:city-hash
	#:cl-fad)
  (:export :main
	   :get-lambda-list))

(defpackage clyde-listener
  (:use #:cl #:cl-ncurses
	#:moira
	;#:shellpool
	#:cl-string-match
	#:cl-string-complete
	#:colorize))

(load "sources.lisp")
(load "main.lisp")

