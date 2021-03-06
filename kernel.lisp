(in-package #:butler)


(defun kernel-heartbeat (heartbeat-socket)
  (zmq:device :rep heartbeat-socket heartbeat-socket))


(defun dispatch-control-messages (control-socket iopub-socket))


(defun kernel-start (config)
  (zmq:with-context (ctx 1)
    (zmq:with-socket (heartbeat-socket ctx :rep)
      (flet ((cfg (key) (config-value key config)))
        (zmq:bind heartbeat-socket (socket-bind-address (cfg :transport)
                                                        (cfg :ip)
                                                        (cfg :hb--port)))
        (bordeaux-threads:make-thread
         #'(lambda () (kernel-heartbeat heartbeat-socket))))))
  (zmq:with-context (ctx 2)
    (zmq:with-sockets ((shell-socket ctx :router :thread-safe t)
                       (control-socket ctx :router :thread-safe t)
                       (stdin-socket ctx :router :thread-safe t)
                       (iopub-socket ctx :pub :thread-safe t))
      (flet ((cfg (key) (config-value key config)))
        (zmq:bind shell-socket (socket-bind-address (cfg :transport)
                                                    (cfg :ip)
                                                    (cfg :shell--port)))
        (zmq:bind control-socket (socket-bind-address (cfg :transport)
                                                      (cfg :ip)
                                                      (cfg :control--port)))
        (zmq:bind stdin-socket (socket-bind-address (cfg :transport)
                                                      (cfg :ip)
                                                      (cfg :stdin--port)))
        (zmq:bind iopub-socket (socket-bind-address (cfg :transport)
                                                      (cfg :ip)
                                                      (cfg :iopub--port)))
        (bordeaux-threads:make-thread
         #'(lambda () (dispatch-control-messages control-socket iopub-socket)))))))
