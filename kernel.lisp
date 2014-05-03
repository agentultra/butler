(in-package #:butler)


(defun kernel-heartbeat (heartbeat-socket)
  (zmq:device :rep heartbeat-socket heartbeat-socket))


(defun kernel-start (config)
  (zmq:with-context (ctx 1)
    (zmq:with-socket (heartbeat-socket ctx :rep)
      (flet ((cfg (key) (config-value key config)))
        (zmq:bind heartbeat-socket (socket-bind-address (cfg :transport)
                                                        (cfg :ip)
                                                        (cfg :hb--port)))
        (bordeaux-threads:make-thread
         #'(lambda () (kernel-heartbeat heartbeat-socket)))))))
