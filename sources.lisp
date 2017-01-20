(in-package :clyde)

(defun list-all-symbols (pack)
  (let ((lst nil))
    (do-all-symbols (s lst)
      (when (eq (find-package pack) (symbol-package s)) (push s lst))
      lst)))

(defun list-all-members (item seq)
  (remove-if (lambda (x)
		   (not (string-contains-brute item x)))
	  seq))
    

(defun parse-parens (str &optional acc (cnt 0))
  (if (stringp str) (parse-parens (coerce str 'list))
    (cond
      ((and (eql (car str) #\)) (= cnt 1))
       (coerce (reverse (cons (car str) acc)) 'string))
      ((eql (car str) #\() (parse-parens (cdr str) (cons (car str) acc)
					 (1+ cnt)))
      ((eql (car str) #\))  (parse-parens (cdr str) (cons (car str) acc)
					  (1- cnt)))
      ((>= cnt 1) (parse-parens (cdr str) (cons (car str) acc) cnt))
      (t (parse-parens (cdr str))))))

      

(defparameter *symbol-list* (flatten (mapcar #'list-all-symbols (list-all-packages))))

(defparameter *symbol-string-list* (mapcar #'string *symbol-list*))

(defparameter *function-list* (remove-if (lambda (x)
					   (not (ignore-errors (symbol-function x))))
					 *symbol-list*))

(defmacro desc-string (func)
  "Returns the description of func as a string
  to allow access to the description for other
  uses"
  `(let ((strm (make-string-output-stream)))
     (describe ',func strm)
     (get-output-stream-string strm)))

(defmacro get-lambda-list (func)
  "gets the names of input variables to functions"
	(let ((string (gensym)))
    `(let ((,string (string-upcase (desc-string ,func))))
       (with-input-from-string (x ,string
				    :start (string-contains-brute "LAMBDA-LIST:" ,string))
       (read-line x)))))

(defmacro get-declared-types (func)
  "gets the declared type of func"
  (let ((string (gensym)))
    `(let ((,string (string-upcase (desc-string ,func))))
       (concatenate 'string "DECLARED TYPE: "
		    (parse-parens (subseq ,string (string-contains-brute "DECLARED TYPE" ,string)))
       ))))

