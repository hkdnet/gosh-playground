txt/request.txt: txt/request.txt.raw
	ruby -e 'File.write("txt/request.txt", File.read("txt/request.txt.raw").gsub("\n", "\r\n"))'
