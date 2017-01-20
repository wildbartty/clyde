(unless (find-package 'clyde)
  (ql:quickload '(ltk
		 moira colorize
		 ;alexandria
		 cl-ncurses ;shellpool
		 cl-string-match cl-string-complete
		 ;cl-cffi-gtk
		 city-hash cl-fad
		 )))

(defun load-files (files &key &allow-other-keys)
  (when files (progn
		(load (car files))
		(load-files (cdr files)))))






