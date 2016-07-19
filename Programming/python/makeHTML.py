#!/usr/bin/python

filename = 'index.html'
title = 'TITLE'

# Debugging statement:
FILE = open(filename, 'w')

# write the beginning of the html code:
FILE.write("<html>\n<head>\n\n<title>\n")
FILE.write(title)
FILE.write("\n</title>\n\n</head>\n\n")
FILE.write("<body bgcolor=\"white\">\n\n\n\n")

# write the end of the body of the html code:
FILE.write("\n\n</body>\n\n</html>\n\n")

# close the file for editing:
FILE.close()

