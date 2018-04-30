(load "./csv.scm")

(use gauche.record)

(define header '())
(define bodies '())

(let ((data (file->csv "csv/idols.csv")))
  (set! header (car data))
  (set! bodies (cdr data)))

(define-record-type idol #t #t header)

(define (bodies->idols bodies)
  (let loop ([bs bodies] [idols '()])
    (if (null? bs)
      idols
      (let ((b (car bs)))
        (let ((idol (make-idol b)))
          (loop (cdr bs) (cons idol idols)))))))

(define idols (bodies->idols bodies))

(let loop ([idols idols])
  (if (not (null? idols))
    (let ((idol (car idols)))
      (display idol)(newline)
      (loop (cdr idols)))))
