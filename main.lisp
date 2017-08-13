(defmacro load-once (&rest rest)
  (if (not (car rest))
      t
      `(progn
	 (unless (find-package ,(car rest))
	   (ql:quickload ,(car rest)))
	 (load-once ,(cdr rest)))))


(load-once :ltk)


(defpackage clyde-tk
  (:use :cl
	:ltk
					;	:ltk-mw
	)
  )

(in-package clyde)

(defmacro make-win (widget)
  
  `(with-ltk ()
     (let ((w (make-instance ',widget)))
       (pack w))))	

(defun hello ()
  (with-ltk ()
    (let* ((canva (make-instance 'canvas))
	   (b (make-instance 'button
			     :master canva
			     :text "hi"
			     :command (lambda ()
					(format t "~a~%" (text canva))))))
      (create-window canva 40 20 b)
      (pack canva))))

(defun hello-2 ()
  (with-ltk ()
    (let* ((f (make-instance 'frame))
	   (b1 (make-instance 'button
			      :master f
			      :text "But 1"
			      :command (lambda ()
					 (format t "Butt 1~&"))))
	   (b2 (make-instance 'button
			      :master f
			      :text "But 2"
			      :command (lambda ()
					 (format t "Butt 2~&"))))
	   (b3 (make-instance 'button
			      :master f
			      :text "but 3"
			      :command (lambda ()
					 (format t "Butt 3 ~&"))))
	   (words (make-instance 'text
				 :master f)))
      (pack f)
      (pack b1 :side :left)
      (pack b2 :side :left)
      (pack b3 :side :top)
      (pack words :side :left)
      (configure f :borderwidth 3))))


(defmacro manual-test ()
  `(progn
     (start-wish)
     (let* ((bob (make-instance 'button)))
       (progn
	 (pack bob)
	 (mainloop)))))

(defun async-test ()
  (with-ltk (:serve-event t)
    (let* ((f (make-instance 'frame))
	   (b1 (make-instance 'button
			      :master f
			      :text "But 1"
			      :command (lambda ()
					 (format t "Butt 1~&"))))
	   (b2 (make-instance 'button
			      :master f
			      :text "But 2"
			      :command (lambda ()
					 (format t "Butt 2~&"))))
	   (b3 (make-instance 'button
			      :master f
			      :text "but 3"
			      :command (lambda ()
					 (format t "Butt 3 ~&"))))
	   (words (make-instance 'text
				 :master f)))
      (pack f)
      (pack b1 :side :left)
      (pack b2 :side :left)
      (pack b3 :side :top)
      (pack words :side :left)
      (configure f :borderwidth 3))))

(defun man-test ()
  (progn
    (start-wish)
    (let ((bob (make-instance 'button)))
      (pack bob)
      (mainloop))))

(defun ide-test ()
  (with-ltk ()
    (let* ((main (make-instance 'toplevel))
	   (scrl-bar (make-instance 'scrollbar
				    :master main))
	   (lbl (make-instance 'label
			       :master scrl-bar
			       :text "1"))
	   (txt (make-instance 'text :master scrl-bar)))
      
      (pack lbl :side :left :anchor :ne)
      (pack txt)
      (pack scrl-bar)
      (bind txt "<Insert>" 
	    (lambda (a)
	      (format t "~a ~&" ))))))


