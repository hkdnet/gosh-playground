(load "./csv.scm")

(use gauche.record)

(define-record-type idol #t #t '(name age))
(let ((data (file->csv "csv/idols.csv")))
  (let ((header (car data)) (bodies (cdr data)))
    (let loop ([bs bodies])
      (if (not (null? bs))
        (let ((b (car bs)))
          (let ((idol (make-idol b)))
            (display idol)(newline)
            (loop (cdr bs))))))))
