(use gauche.record)
(use gauche.net)
(use file.util)

(load "./file-reader.scm")

(define-record-type
  first-line
  (build-first-line method path)
  #t
  (method method)
  (path path))

(define (parse-first-line line)
  (let ((tmp (string-split line " " 3)))
    (let ((method (car tmp)) (path (car (cdr tmp))))
      (build-first-line method path))))

(define (parse-header-line line)
  (string-split line ": " 2))

(define (parse-header header)
  (let ((lines (string-split header "\r\n")))
    (reverse (fold cons '() (map parse-header-line lines)))))

(define (parse-body body)
  body)

(define (parse-request request)
  (let ((complete-request (string-incomplete->complete request)))
    (let ((arr (string-split complete-request "\r\n\r\n" 2)))
      (let ((first-line (car arr)) (arr2 (cdr arr)))
        (let ((header (car arr2)) (body (cdr arr2)))
          `(,(parse-first-line first-line) ,(parse-header header) ,(parse-body body)))))))

(define public-path
  (build-path (current-directory) "public"))

(define (create-file-content-response path)
  (let ((file-path (build-path public-path #"./~path"))) ; ディレクトリトラバーサル
    (let ((text (read-from-file file-path)))
      (let ((content-length (string-length text)))
        #"HTTP/1.1 200 OK\r\nContent-Length: ~content-length\r\n\r\n~text"))))

(define (build-response first-line headers body)
  (let ((method (method first-line)))
    (if (string=? method "GET")
      (let ((path (path first-line)))
        (create-file-content-response path))
      "HTTP/1.1 400 Bad Request\r\nContent-Length: 22\r\n\r\nNot supported method\r\n")))

(define (handler sock)
  (let ((recv (socket-recv sock 1024)))
    (if (<= (string-length recv) 0)
      (begin
        (display "exit\n")
        (socket-close sock)
        (exit)))
    (let ((parsed (parse-request recv)))
      (let ((first-line (car parsed)) (headers (cdr parsed)) (body (cddr parsed)))
        (let ((resp (build-response first-line headers body)))
          (socket-send sock resp)))))
  (handler sock))
