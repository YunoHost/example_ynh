#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
#  myServer.py
#  
#  Copyright 2019 swinter <swinter@T420>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  
import logging
from http.server import BaseHTTPRequestHandler
import socketserver

PORT = 7080

class MyHandler(BaseHTTPRequestHandler):
	def do_HEAD(self):
		self.send_response(200)
		self.send_header("Content-type", "text/html")
		self.end_headers()
	def do_GET(self):
		"""Respond to a GET request."""
		self.send_response(200)
		self.send_header("Content-type", "text/html")
		self.end_headers()
		self.wfile.write("<html><head><title>Title goes here.</title></head>".encode("utf-8"))
		self.wfile.write("<body><p>This is a test.</p>".encode("utf-8"))
		# If someone went to "http://something.somewhere.net/foo/bar/",
		# then s.path equals "/foo/bar/".
		self.wfile.write(("<p>You accessed path: %s</p>" % self.path).encode("utf-8"))
		self.wfile.write("</body></html>".encode("utf-8"))
		return


def main(args):
	
	logging.basicConfig(filename='myServer.log',level=logging.DEBUG)
	logging.basicConfig(format='%(asctime)s %(message)s')
	logging.info('myServer start')
	httpd = socketserver.TCPServer(("", PORT), MyHandler)
	logging.info("myServer serving at port " +  str(PORT))
	try:
		httpd.serve_forever()
	except KeyboardInterrupt:
		pass
	httpd.server_close()
	logging.info('myServer closed')
	
if __name__ == '__main__':
	import sys
	sys.exit(main(sys.argv))
