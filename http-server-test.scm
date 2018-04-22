(use gauche.test)

(test-start "http-server")
(load "./http-server")

(test-section "parse-first-line")
(test
  "第一行目のパース"
  '((method "GET") (path "/"))
  (lambda () (parse-first-line "GET / HTTP/1.1\r\n" )))

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
