(use gauche.net)

(define (main args)
  (let ((client-sock (make-client-socket "127.0.0.1" 5000)))
    (socket-send client-sock "Hello\n")))
