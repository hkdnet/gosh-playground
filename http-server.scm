(use gauche.net)

(define (parse-first-line line)
  (let ((tmp (string-split line " " 3)))
    (let ((method (car tmp)) (path (car (cdr tmp))))
      `((method ,method) (path ,path)))))

(define (parse-header-line line)
  (string-split line ": " 2))

(define (parse-header header)
  (let ((lines (string-split header "\r\n")))
    (reverse (fold cons '() (map parse-header-line lines)))))

(define (parse-body body)
  body)

(define (parse-request request)
  (let ((arr (string-split request "\r\n\r\n" 2)))
    (let ((first-line (car arr)) (arr2 (cdr arr)))
      (let ((header (car arr2)) (body (cdr arr2)))
        `(,(parse-first-line first-line) ,(parse-header header) ,(parse-body body))))))

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
      (let ((first-line (car parsed)) (headers (cdr parsed)) (body (cddr parsed)))
        (display first-line)
        (let ((resp (build-response headers body)))
          (socket-send sock resp)))))
  (handler sock))
