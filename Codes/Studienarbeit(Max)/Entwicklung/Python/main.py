from file_writer import file_writer
from TCP_server import TCP_server
from dataconverter import dataconverter

file = file_writer()
server = TCP_server()

while 1 == 1:
    file.write_line(dataconverter(server.receive_exact(28)))