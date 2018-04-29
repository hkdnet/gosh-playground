(define-syntax nil!
  (syntax-rules () ((_ x) (set! x '()))))

(let ((x 1))
  (display x)(newline)
  (begin
    (set! x '())
    (display x)(newline))
  (set! x 3)
  (display x)(newline)
  (begin
    (nil! x)
    (display x))(newline))
