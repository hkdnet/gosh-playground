(use gauche.test)

(test-start "http-server")
(load "./http-server")

(test-section "parse-first-line")
(let ((parsed (parse-first-line "GET / HTTP/1.1\r\n")))
  (test "method"
    "GET"
    (lambda () (slot-ref parsed 'method)))
  (test "path"
    "/"
    (lambda () (slot-ref parsed 'path)))
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
  (lambda () (parse-header '("foo: bar" "hoge: fuga"))))

(test-section "parse-request")
(let ((expected-first-line (make <first-line> :method "GET" :path "/index.html"))
      (expected-header '(
        ("Host" "localhost:5000")
        ("Connection" "keep-alive")
        ("Pragma" "no-cache")
        ("Cache-Control" "no-cache")
        ("Upgrade-Insecure-Requests" "1")
        ("User-Agent" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36")
        ("Accept" "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8")
        ("Accept-Encoding" "gzip, deflate, br")
        ("Accept-Language" "en-US,en;q=0.9,ja;q=0.8")))
      (actual (parse-request "GET /index.html HTTP/1.1\r\nHost: localhost:5000\r\nConnection: keep-alive\r\nPragma: no-cache\r\nCache-Control: no-cache\r\nUpgrade-Insecure-Requests: 1\r\nUser-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate, br\r\nAccept-Language: en-US,en;q=0.9,ja;q=0.8")))
  (test "first-line" expected-first-line (lambda() (car actual)))
  (test "headers" expected-header (lambda() (car (cdr actual)))))


(test-end :exit-on-failure #t)
