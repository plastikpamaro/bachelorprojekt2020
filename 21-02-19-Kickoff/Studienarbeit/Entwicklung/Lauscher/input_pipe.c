/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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
#include <bcm2835.h>


#define OUR_INPUT_FIFO_NAME "/tmp/my_fifo"

void create_pipe(int* input_fifo_filestream){
    int result;
    printf("Creating pipe\n");
	result = mkfifo(OUR_INPUT_FIFO_NAME, 0777);		//(This will fail if the fifo already exists in the system from the app previously running, this is fine)
	if (result == 0)
	{
		//FIFO CREATED
		printf("New FIFO created: %s\n", OUR_INPUT_FIFO_NAME);
	}

	printf("Process %d opening FIFO %s\n", getpid(), OUR_INPUT_FIFO_NAME);
	*input_fifo_filestream = open(OUR_INPUT_FIFO_NAME, (O_RDONLY));
					//Possible flags:
					//	O_RDONLY - Open for reading only.
					//	O_WRONLY - Open for writing only.
					//	O_NDELAY / O_NONBLOCK (same function) - Enables nonblocking mode. When set read requests on the file can return immediately with a failure status
					//											if there is no input immediately available (instead of blocking). Likewise, write requests can also return
					//											immediately with a failure status if the output can't be written immediately.
	if (*input_fifo_filestream != -1)
		printf("Opened FIFO: %i\n", input_fifo_filestream);
}

/*void main(){
	
	int our_input_fifo_filestream = -1;
	
	// read data and send it
	//uint32_t rx_buffer[28];
	uint32_t rx_buffer[28] = {0};
	while (1==1){
		int rx_length = read(our_input_fifo_filestream, (void*)rx_buffer, 28);
		
	}
 
}*/

