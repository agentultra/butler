(in-package #:butler)


(defvar *DELIM* "<IDS|MSG>")


(defclass message ()
  ((identities :accessor msg-ids
               :initform '()
               :type list)
   (signature :reader msg-hmac
              :writer nil
              :initform ""
              :type string)
   (header :accessor msg-header
           :initform '()
           :type alist)
   (parent-header :accessor parent-header
                  :initform '()
                  :type alist)
   (metadata :accessor msg-meta
             :initform '()
             :type alist)
   (content :initform '()
            :type alist)
   (blob :type string)))


(defun make-message (identities header content
                     &optional
                       (parent-header '())
                       (metadata '())
                       (blob ""))
  (make-instance 'message
                 :identities identities
                 :header header
                 :parent-header parent-header
                 :metadata metadata
                 :content content
                 :blob blob))


(defun serialize-message (msg &key (hmac-key nil)))


(defun unserialize-message (byte-string)
  (let ((delim-index (search *DELIM* byte-string)))
    (values
     (subseq byte-string 0 delim-index)
     (subseq byte-string (1+ delim-index)))))
