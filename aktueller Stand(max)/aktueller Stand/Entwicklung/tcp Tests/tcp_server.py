import socket

TCP_IP = '192.168.178.28'
#TCP_IP = '192.168.178.25'
TCP_PORT = 51717
#TCP_PORT = 61915
BUFFER_SIZE = 1024
MESSAGE = 35

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((TCP_IP, TCP_PORT))
#a = bytearray(1)
#a[0] = 0x42
#s.send(a)
test = MESSAGE.to_bytes(1,byteorder='big')
s.send(test)
data = s.recv(BUFFER_SIZE)
d2 = 0
test = d2.to_bytes(1,byteorder='big')
s.send(test)
s.close()

print ("received data:" + str(data))