;;;; butler.asd

(asdf:defsystem #:butler
  :serial t
  :description "Butler is a Common Lisp kernel for an iPython client"
  :author "James King <james@agentultra.com>"
  :license "MIT"
  :depends-on (#:zmq
               #:cl-json
               #:bordeaux-threads)
  :components ((:file "package")
               (:file "utils" :depends-on ("package"))
               (:file "kernel" :depends-on ("utils"))
               (:file "butler" :depends-on ("kernel"))))
