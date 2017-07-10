(in-package :common-lisp-user)

(defpackage clim-test
  (:use #:clim #:clim-lisp)
  (:export app-main
	   *superapp*))

(in-package :clim-test)

(define-application-frame superapp ()
  ((current-number :initform nil :accessor current-number))
  (:pointer-documentation t)
  (:panes
   (app :application :display-time nil
	:height 400
	:width 600
	:display-function 'display-app)
   (int :interactor :height 400 :width 600))
  (:layouts
   (default (vertically () app int))))

(defun display-app (frame pane)
  (let ((number (current-number frame)))
    (format pane "~a is ~a~%" number
	    (if (eql (type-of number) (type-of 42))
		(if (oddp number)
		    "odd"
		    "even")
		"not a number"))))
	      

(defparameter *superapp* (make-application-frame 'superapp))

(defun app-main ()
  (run-frame-top-level (make-application-frame 'superapp)))

(define-superapp-command (com-quit :name t) ()
  (frame-exit *application-frame*))

(define-superapp-command (com-parity :name t) ((number integer))
  (format t "~a is ~a~%" number
	  (if (oddp number) "odd" "even")))
