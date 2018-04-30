all: txt/request.txt txt/chrome-req.txt check
txt/request.txt: txt/request.txt.raw
	ruby -e 'File.write("txt/request.txt", File.read("txt/request.txt.raw").gsub("\n", "\r\n"))'
txt/chrome-req.txt: txt/chrome-req.txt.raw
	ruby -e 'File.write("txt/chrome-req.txt", File.read("txt/chrome-req.txt.raw").gsub("\n", "\r\n"))'
check:
	mkdir -p log
	gosh http-server-test.scm
	gosh csv-test.scm

.PHONY: check all
