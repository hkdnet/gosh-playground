(use gauche.test)

(test-start "http-server")
(load "./http-server")

(test-section "parse-first-line")
(test "feature 1-1" '((method GET) (path /)) (lambda () (parse-first-line "GET / HTTP/1.1" )))

(test-end :exit-on-failure #t)
