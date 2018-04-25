(use gauche.net)
(use file.util)

(define (display-response resp)
  (display resp))

(define (handler sock)
  (let ((recv (socket-recv sock 1024)))
    (if (<= (string-length recv) 0)
      (begin
        (socket-close sock)
        (exit)))
    (display-response recv)(newline))
  (handler sock))

(define (main args)
  (receive (_ filename) (apply values args)
    (let ((client-sock (make-client-socket "127.0.0.1" 5000)))
      (socket-send client-sock (file->string filename))
      (handler client-sock))))
