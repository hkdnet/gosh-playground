(let ((p (open-input-file "txt/request.txt")))
  (let loop ((ls1 '()) (c (read-char p)))
    (if (eof-object? c)
      (begin
        (close-input-port p)
        (let ((str (list->string (reverse ls1))))
          (display str)))
      (loop (cons c ls1) (read-char p)))))
