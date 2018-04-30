(load "./csv.scm")

(use gauche.record)

(define header '())
(define bodies '())

(let ((data (file->csv "csv/idols.csv")))
  (set! header (car data))
  (set! bodies (cdr data)))

(define-record-type idol #t #t header)

(let loop ([bs bodies])
  (if (not (null? bs))
    (let ((b (car bs)))
      (let ((idol (make-idol b)))
        (display idol)(newline)
        (loop (cdr bs))))))
