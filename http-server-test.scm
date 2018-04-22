(use gauche.test)

(test-start "http-server")
(load "./http-server")

(test-section "parse-first-line")
(let ((parsed (parse-first-line "GET / HTTP/1.1\r\n")))
  (test "type"
    #t
    (lambda () (first-line? parsed)))
  (test "method"
    "GET"
    (lambda () (method parsed)))
  (test "path"
    "/"
    (lambda () (path parsed)))
  )

(test-section "parse-header-line")
(test
  "ヘッダー行の分割"
  '("foo" "bar")
  (lambda () (parse-header-line "foo: bar")))

(test-section "parse-header")
(test
  "複数行で改行文字とか入らないこと"
  '(("foo" "bar") ("hoge" "fuga"))
  (lambda () (parse-header "foo: bar\r\nhoge: fuga" )))

(test-end :exit-on-failure #t)
