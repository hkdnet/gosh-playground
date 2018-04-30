(use file.util)

(define-module CSV
(define (to-lines text)
  (string-split text #/\r?\n/))
(define (parse-csv filename)
  (let ((text (file->string filename)))
    (let ((lines (to-lines text)))
      lines)))
)
