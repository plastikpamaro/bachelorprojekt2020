#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#define OUR_INPUT_FIFO_NAME "/tmp/my_fifo"

void main(){

	int our_input_fifo_filestream = -1;


	//--------------------------------------
	//----- CREATE A FIFO / NAMED PIPE -----
	//--------------------------------------
	int result;

	printf("Making FIFO...\n");
	result = mkfifo(OUR_INPUT_FIFO_NAME, 0777);		//(This will fail if the fifo already exists in the system from the app previously running, this is fine)
	if (result == 0)
	{
		//FIFO CREATED
		printf("New FIFO created: %s\n", OUR_INPUT_FIFO_NAME);
	}

	printf("Process %d opening FIFO %s\n", getpid(), OUR_INPUT_FIFO_NAME);
	our_input_fifo_filestream = open(OUR_INPUT_FIFO_NAME, (O_RDONLY|O_NONBLOCK));
					//Possible flags:
					//	O_RDONLY - Open for reading only.
					//	O_WRONLY - Open for writing only.
					//	O_NDELAY / O_NONBLOCK (same function) - Enables nonblocking mode. When set read requests on the file can return immediately with a failure status
					//											if there is no input immediately available (instead of blocking). Likewise, write requests can also return
					//											immediately with a failure status if the output can't be written immediately.
	if (our_input_fifo_filestream != -1)
		printf("Opened FIFO: %i\n", our_input_fifo_filestream);
	

	while (1==1) {
	//---------------------------------------------
		//----- CHECK FIFO FOR ANY RECEIVED BYTES -----
		//---------------------------------------------
		// Read up to 255 characters from the port if they are there
		if (our_input_fifo_filestream != -1)
		{
			unsigned char rx_buffer[256];
			int rx_length = read(our_input_fifo_filestream, (void*)rx_buffer, 255);		//Filestream, buffer to store in, number of bytes to read (max)
			if (rx_length < 0)
			{
				//An error occured (this can happen)
				//printf("FIFO Read error\n");
			}
			else if (rx_length == 0)
			{
				//No data waiting
			}
			else
			{
				//Bytes received
				rx_buffer[rx_length] = '\0';
				printf("FIFO %i bytes read : %s\n", rx_length, rx_buffer);
			}
		}
	}
}
