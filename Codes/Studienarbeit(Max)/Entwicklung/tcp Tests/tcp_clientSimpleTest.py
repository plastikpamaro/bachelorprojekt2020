import socket

#TCP_IP = '192.168.178.28'
TCP_IP = '192.254.77.2'
TCP_PORT = 51717
#TCP_PORT = 61915
BUFFER_SIZE = 1
MESSAGE = 8

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((TCP_IP, TCP_PORT))
#a = bytearray(1)
#a[0] = 0x42
#s.send(a)
test = True

while test:
    data = s.recv(BUFFER_SIZE)
    #print (hex(data[0]))

s.close()

