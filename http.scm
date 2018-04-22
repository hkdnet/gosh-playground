(load "./http-server")

(define (main args)
  (display args)(newline)
  (let ((server-sock (make-server-socket `inet 5000)))
    (display "waiting...\n")
    (let ((sock (socket-accept server-sock)))
      (handler sock))))
