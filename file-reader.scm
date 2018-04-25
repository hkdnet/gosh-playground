(define (read-from-file filename)
  (with-input-from-file filename
    (lambda ()
      (let loop ((ls1 '()) (c (read-char)))
        (if (eof-object? c)
          (let ((str (list->string (reverse ls1))))
            str)
          (loop (cons c ls1) (read-char)))))))
