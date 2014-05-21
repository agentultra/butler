;;;; butler.asd

(asdf:defsystem #:butler
  :serial t
  :description "Butler is a Common Lisp kernel for an iPython client"
  :author "James King <james@agentultra.com>"
  :license "MIT"
  :depends-on (#:zmq
               #:cl-json
               #:bordeaux-threads
               #:ironclad)
  :components ((:file "package")
               (:file "utils" :depends-on ("package"))
               (:file "session" :depends-on ("utils"))
               (:file "kernel" :depends-on ("session"))
               (:file "butler" :depends-on ("kernel"))))
