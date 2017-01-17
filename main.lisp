(in-package clyde)

(defun scribble ()
  (with-ltk ()
   (let* ((canvas (make-instance 'canvas))
          (down nil))
     (pack canvas)
     (bind canvas "<ButtonPress-1>"
           (lambda (evt)
             (setf down t)                                    
             (create-oval canvas
                      (- (event-x evt) 10) (- (event-y evt) 10)
                      (+ (event-x evt) 10) (+ (event-y evt) 10))))
     (bind canvas "<ButtonRelease-1>" (lambda (evt) 
                                        (declare (ignore evt))
                                        (setf down nil)))
     (bind canvas "<Motion>"
           (lambda (evt)
             (when down
               (create-oval canvas
                    (- (event-x evt) 10) (- (event-y evt) 10)
                    (+ (event-x evt) 10) (+ (event-y evt) 10))))))))

(defun text-test ()
  (with-ltk ()
	(let ((txt (make-instance 'text))
	      (scrl (make-instance 'scrollbar)))
	  (pack txt :side :left)
	  (pack scrl))))

(defun canvas-test ()
  (with-ltk ()
	    (let* ((sc (make-instance 'scrolled-canvas))
		   (c (canvas sc)))
	     (pack sc :fill :both)
	     (scrollregion c 0 0 200 200)
	      ;(pack scrl)
	      )))
