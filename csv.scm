(define-module CSV

(use file.util)
(use srfi-13)

; TODO: " で囲われてるときとかがあるので結局自前で1文字ずつ見るしかない
(define (to-lines text)
  (string-split text #/\r?\n/))
(define (parse-csv text)
  (let ((lines (filter (lambda (line) (not (string-null? line))) (to-lines text))))
    (map (lambda (line) (string-split line ",")) lines)))
(define (file->csv filename)
  (let ((text (file->string filename)))
    (parse-csv text)))
)
