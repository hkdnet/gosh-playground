(load "./csv")

(with-module CSV
  (use gauche.test)
  (test-start "csv")
  (test-section "to-lines")
  (test "with \\n" '("a" "b") (lambda() to-lines "a\nb"))
)
