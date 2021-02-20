#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdint.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>
#include <errno.h>
#include<sys/socket.h>
#include<arpa/inet.h>

#define OUR_INPUT_FIFO_NAME "/tmp/my_fifo"
#define TCP_PORT 5005
#define	TCP_IP "192.168.42.23"

// stuff from: https://aticleworld.com/socket-programming-in-c-using-tcpip
short SocketCreate(void)
{
    short hSocket;
    printf("Create the socket\n");
    hSocket = socket(AF_INET, SOCK_STREAM, 0);
    return hSocket;
}
//try to connect with server
int SocketConnect(int hSocket)
{
    int iRetval=-1;
    int ServerPort = TCP_PORT;
    struct sockaddr_in remote= {0};
    remote.sin_addr.s_addr = inet_addr(TCP_IP); 
    remote.sin_family = AF_INET;
    remote.sin_port = htons(ServerPort);
    iRetval = connect(hSocket,(struct sockaddr *)&remote,sizeof(struct sockaddr_in));
    return iRetval;
}
// Send the data to the server and set the timeout of 20 seconds
int SocketSend(int hSocket,uint32_t* Rqst,short lenRqst)
{
    int shortRetval = -1;
    struct timeval tv;
    tv.tv_sec = 20;  /* 20 Secs Timeout */
    tv.tv_usec = 0;
    if(setsockopt(hSocket,SOL_SOCKET,SO_SNDTIMEO,(char *)&tv,sizeof(tv)) < 0)
    {
        printf("Time Out\n");
        return -1;
    }
    shortRetval = send(hSocket, Rqst, lenRqst, 0);
    return shortRetval;
}



void main(){
	// connection to TCP server
	int hSocket;
	struct sockaddr_in server;
	printf("Connect to TCP server\n");
	hSocket = SocketCreate();
    if(hSocket == -1)
    {
        printf("Could not create socket\n");
        exit;
    }
    printf("Socket is created\n");
    //Connect to remote server
    if (SocketConnect(hSocket) < 0)
    {
        perror("connect failed.\n");
        exit;
    }
    printf("Sucessfully conected with server\n");
	
	
	// open pipe
	int result;
	int our_input_fifo_filestream = -1;
	printf("Creating pipe\n");
	result = mkfifo(OUR_INPUT_FIFO_NAME, 0777);		//(This will fail if the fifo already exists in the system from the app previously running, this is fine)
	if (result == 0)
	{
		//FIFO CREATED
		printf("New FIFO created: %s\n", OUR_INPUT_FIFO_NAME);
	}

	printf("Process %d opening FIFO %s\n", getpid(), OUR_INPUT_FIFO_NAME);
	our_input_fifo_filestream = open(OUR_INPUT_FIFO_NAME, (O_RDONLY));
					//Possible flags:
					//	O_RDONLY - Open for reading only.
					//	O_WRONLY - Open for writing only.
					//	O_NDELAY / O_NONBLOCK (same function) - Enables nonblocking mode. When set read requests on the file can return immediately with a failure status
					//											if there is no input immediately available (instead of blocking). Likewise, write requests can also return
					//											immediately with a failure status if the output can't be written immediately.
	if (our_input_fifo_filestream != -1)
		printf("Opened FIFO: %i\n", our_input_fifo_filestream);
	
	// read data and send it
	//uint32_t rx_buffer[28];
	uint32_t rx_buffer[28] = {0};
	while (1==1){
		int rx_length = read(our_input_fifo_filestream, (void*)rx_buffer, 28);
		if (rx_length > 0){
			SocketSend(hSocket, rx_buffer, rx_length);	
		}
	}
	
	close(hSocket);
    shutdown(hSocket,0);
    shutdown(hSocket,1);
	shutdown(hSocket,2);
 
}

