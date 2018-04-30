(load "./csv.scm")

(with-module CSV
  (let ((data (file->csv "csv/idols.csv")))
    (let ((header (car data)) (bodies (cdr data)))
      (display header)(newline)
      (display bodies)(newline)))
)
