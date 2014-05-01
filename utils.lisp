;;; Various utilities

(in-package #:butler)


(defun command-line-args ()
  (or
   #+CCL ccl:*command-line-argument-list*
   nil))


(defun get-configuration (path)
  (cl-json:decode-json-from-source path))


(defun socket-bind-address (transport ip port)
  (format nil "~A://~A:~A" transport ip port))
