import socket

class TCP_server():
    def __init__(self, TCP_PORT=5005):
        #get local IP 
        hostname = socket.gethostname()
        local_ip = socket.gethostbyname(hostname)
        print("Openening TCP Verver at: " +local_ip)
        print("Port: " + str(TCP_PORT) + "\n")

        # open socket
        self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server.bind((local_ip, TCP_PORT))
        self.server.listen(1)

        # wait for connection and accept it
        print("waiting for client")
        self.conn, addr = self.server.accept()
        print ('Connection address:', addr)

    def __del__(self):
        self.conn.close()
        print("connection closed")
        self.server.close()
        print("server closed")


    def receive(self, BUFFERSIZE=1024):
        data = self.conn.recv(BUFFERSIZE)
        return data

    def receive_exact(self,BUFFERSIZE=1024):
        data = bytearray(0)
        size = 0
        while len(data) < BUFFERSIZE:
            data.extend( self.conn.recv(BUFFERSIZE-size))
            size = len(data)
        return data





if __name__ == "__main__":
    server = TCP_server()
    while 1==1:
        server.receive()
        print ("received data:", server.receive(5))
        pass