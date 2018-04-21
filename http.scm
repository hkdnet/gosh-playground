(use gauche.net)

(define (parse-header header)
  (let ((lines (string-split header "\r\n")))
    (fold cons '() lines)))

(define (parse-request request)
  (let ((arr (string-split request "\r\n\r\n" 2)))
    (let ((header (car arr)) (body (cdr arr)))
      (parse-header header))))

(define (build-response headers body)
  "HTTP/1.1 200 OK\r\nContent-Length: 7\r\n\r\nHello\r\n")

(define (handler sock)
  (let ((recv (socket-recv sock 1024)))
    (if (<= (string-length recv) 0)
      (begin
        (display "exit\n")
        (socket-close sock)
        (exit)))
    (let ((parsed (parse-request recv)))
      (let ((headers (car parsed)) (body (cdr parsed)))
        (let ((resp (build-response headers body)))
          (socket-send sock resp)))))
  (handler sock))

(define (main args)
  (display args)(newline)
  (let ((server-sock (make-server-socket `inet 5000)))
    (display "waiting...\n")
    (let ((sock (socket-accept server-sock)))
      (handler sock))))
