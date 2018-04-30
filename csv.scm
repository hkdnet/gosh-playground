(define-module CSV

(use file.util)
(define (to-lines text)
  (string-split text #/\r?\n/))
(define (parse-csv text)
  (let ((lines (to-lines text)))
    (map (lambda (line) (string-split line ",")) lines)))
)
