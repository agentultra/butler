(in-package #:butler)


(defun kernel-heartbeat (heartbeat-socket)
  (loop
     (let ((query (make-instance 'zmq:msg)))
       (zmq:recv heartbeat-socket query))
     (zmq:send heartbeat-socket (make-instance 'zmq:msg :data query))))


(defun kernel-start (config)
  (zmq:with-context (ctx 1)
    (zmq:with-socket (heartbeat-socket ctx zmq:rep)
      (zmq:bind heartbeat-socket (socket-bind-address
                                  (cdr (assoc :transport config))
                                  (cdr (assoc :ip config))
                                  (cdr (assoc :hb--port config))))
      (bordeaux-threads:make-thread
       #'(lambda () (kernel-heartbeat heartbeat-socket))))))
