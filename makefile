request.txt: request.txt.raw
	ruby -e 'File.write("request.txt", File.read("request.txt.raw").gsub("\n", "\r\n"))'
