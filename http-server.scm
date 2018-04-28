(use gauche.record)
(use gauche.net)
(use file.util)
(use srfi-13)

(define-class <first-line> ()
  ((method :init-keyword :method)
   (path :init-keyword :path)))

(define-method object-equal? ((a <first-line>) (b <first-line>))
  (and (equal? (slot-ref a 'method) (slot-ref b 'method))
       (equal? (slot-ref a 'path) (slot-ref b 'path))))

(define (parse-first-line line)
  (let ((tmp (string-split line " " 3)))
    (let ((method (car tmp)) (path (car (cdr tmp))))
      (make <first-line> :method method :path path))))

(define (parse-header-line line)
  (string-split line ": " 2))

(define (parse-header header)
  (reverse (fold cons '() (map parse-header-line header))))

(define (parse-body body)
  body)

(define (parse-request request)
  (let ((complete-request (string-incomplete->complete request)))
    (let ((arr (string-split complete-request "\r\n\r\n" 2)))
      (let ((header-lines (string-split (car arr) "\r\n")))
        (let ((first-line (car header-lines)) (header (cdr header-lines)))
          `(,(parse-first-line first-line) ,(parse-header header)))))))

(define public-path
  (build-path (current-directory) "public"))

(define (public-dir? path)
  (string-prefix? public-path path))

(define (create-file-content-response path)
  (let ((file-path (build-path public-path #"./~path")))
    (if (public-dir? file-path)
      (let ((text (file->string file-path)))
        (let ((content-length (string-length text)))
          #"HTTP/1.1 200 OK\r\nContent-Length: ~content-length\r\n\r\n~text"))
      "HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\n\r\n")))

(define (build-response first-line headers body)
  (if (string=? (slot-ref first-line 'method) "GET")
    (create-file-content-response (slot-ref first-line 'path))
    "HTTP/1.1 400 Bad Request\r\nContent-Length: 22\r\n\r\nNot supported method\r\n"))

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
