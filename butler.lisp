;;;; butler.lisp

(in-package #:butler)


(defun main ()
  (let ((config (get-configuration (cadr (command-line-args)))))
    (kernel-start config)))
