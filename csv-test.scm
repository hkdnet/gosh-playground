(load "./csv")

(use gauche.test)
(test-start "csv")

(test-section "parse-csv")
(test "with \\n" '(("a" "b") ("c" "d")) (lambda() (parse-csv "a,b\nc,d")))
(test "with \\n" '(("a" "b") ("c" "d")) (lambda() (parse-csv "a,b\r\nc,d")))

(test-section "file->csv")
(test "csv/idols.csv" '(("name" "age") ("Miki" "15") ("Ritsuko" "19")) (lambda() (file->csv "csv/idols.csv")))
