(load "./csv")

(with-module CSV
  (use gauche.test)
  (test-start "csv")

  (test-section "parse-csv")
  (test "with \\n" '(("a" "b") ("c" "d")) (lambda() (parse-csv "a,b\nc,d")))
  (test "with \\n" '(("a" "b") ("c" "d")) (lambda() (parse-csv "a,b\r\nc,d")))
)
