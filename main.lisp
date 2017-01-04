(in-package clyde)

(defmacro set-destroy-sig (window)
  `(g-signal-connect ,window "destroy"
		     (lambda (widget)
		       (declare (ignore widget))
		       (leave-gtk-main))))




(defun main ()
  (within-main-loop
    (let ((main-win (make-instance 'gtk-window
				   :type :toplevel
				   :title "Halp MAAA!"
				   :default-width 250)))
      (g-signal-connect main-win "destroy"
			(lambda (widget)
			  (declare (ignore widget))
			  (leave-gtk-main)))
      (gtk-widget-show-all main-win))))
        



(let ((tooltip nil))
  (defun get-tip (word)
    (cdr (assoc word
		'(("printf" . "(const char *format, ...)")
                  ("fprintf" . "(FILE *stream, const char *format, ...)")
                  ("sprintf" . "(char *str, const char *format, ...)")
                  ("fputc" . "(int c, FILE *stream)")
                  ("fputs" . "(const char *s, FILE *stream)")
                  ("putc" . "(int c, FILE *stream)")
                  ("putchar" . "(int c)")
                  ("puts" . "(const char *s)"))
                :test #'equal)))
  
  (defun tip-window-new (tip-text)
    (let ((win (make-instance 'gtk-window
			      :type :popup
			      :border-width 0))
	  (event-box (make-instance 'gtk-event-box
				    :border-width 1))
	  (label (make-instance 'gtk-label
				:label tip-text)))
      (gtk-widget-override-font
	label
	(pango-font-description-from-string "Courier"))
      (gtk-widget-override-background-color win
					   :normal
					   (gdk-rgba-parse "Black"))
      (gtk-widget-override-color win :normal (gdk-rgba-parse "Blue"))
      (gtk-container-add event-box label)
      (gtk-container-add win event-box)
      win))
  (defun insert-open-brace (window text-view location)
    (let ((start (gtk-text-iter-copy location)))
      (when (gtk-text-iter-backward-word-start start)
	(let* ((word (string-trim " "
				  (gtk-text-iter-get-text start location)))
	       (tip-text (get-tip word)))
	  (when tip-text
	    (let ((rect (gtk-text-view-get-iter-location text-view location))
		  (win (gtk-text-view-get-window text-view :widget)))
	      (multiple-value-bind (win-x win-y)
		(gtk-text-view-buffer-to-window-coords
		  text-view
		  :widget
		  (gdk-rectangle-x rect)
		  (gdk-rectangle-y rect))
		(multiple-value-bind (x y)
		  (gdk-window-get-origin win)
		  ;;destroy old tool tip window
		  (when tooltip
		    (gtk-widget-destroy tooltip)
		    (setf tooltip nil))
		  ;;make new one
		  (setf tooltip (tip-window-new tip-text))
		  ;;place in proper pos
		  (gtk-window-move tooltip
				   (+ win-x x)
				   (+ win-y y (gdk-rectangle-height rect)))
		  (gtk-widget-show-all tooltip)))))))))
  (defun example-text-view-tooltip ()
    (within-main-loop
      (let* ((window (make-instance 'gtk-window
				    :title "Multiline text search"
				    :type :toplevel
				    :default-width 450
				    :default-height 200))
	     (scrolled (make-instance 'gtk-scrolled-window))
	     (text-view (make-instance 'gtk-text-view
				       :hexpand t
				       :vexpand t))
	     (buffer (gtk-text-view-buffer text-view)))
	(g-signal-connect window "destroy"
			  (lambda (widget)
			    (declare (ignore widget))
			    (when tooltip
			      (gtk-widget-destroy tooltip)
			      (setf tooltip nil))
			    (leave-gtk-main)))
	;;sig handler for text view
	(g-signal-connect buffer "insert-text"
			  (lambda (buffer location text len)
			    (declare (ignore buffer len))
			    (when (equal text "(")
			      (insert-open-brace window text-view location))
			    (when (equal text ")")
			      (when tooltip
				(gtk-widget-destroy tooltip)
				(setf tooltip nil)))))
	;;change font
	(gtk-widget-override-font
	  text-view
	  (pango-font-description-from-string "Courier 12"))

	;;add widgets
	(gtk-container-add scrolled text-view)
	(gtk-container-add window scrolled)
	(gtk-widget-show-all window)))))




