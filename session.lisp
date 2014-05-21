(in-package #:butler)


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
