(use gauche.net)

(define (read-from-file filename)
  (let ((p (open-input-file filename)))
    (let loop ((ls1 '()) (c (read-char p)))
      (if (eof-object? c)
        (begin
          (close-input-port p)
          (let ((str (list->string (reverse ls1))))
            str))
        (loop (cons c ls1) (read-char p)))))
  )

(define (main args)
  (receive (_ filename) (apply values args)
    (let ((client-sock (make-client-socket "127.0.0.1" 5000)))
      (socket-send client-sock (read-from-file filename)))))
