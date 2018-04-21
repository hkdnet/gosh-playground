(use gauche.net)

(define (read-from-file filename)
  (with-input-from-file filename
    (lambda ()
      (let loop ((ls1 '()) (c (read-char)))
        (if (eof-object? c)
          (let ((str (list->string (reverse ls1))))
            str)
          (loop (cons c ls1) (read-char)))))))

(define (main args)
  (receive (_ filename) (apply values args)
    (let ((client-sock (make-client-socket "127.0.0.1" 5000)))
      (socket-send client-sock (read-from-file filename)))))
