#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>
#include <time.h>  
#include <sys/types.h>
#include <sys/stat.h>
#include <bcm2835.h>
  

#define OUR_INPUT_FIFO_NAME "/tmp/my_fifo"



void main(){
	uint32_t  demoData[8] = {0};
	demoData[0] = 0xffffffff;
	demoData[1] = 0x0;
	demoData[2] = 0xaaaaaaaa;
	demoData[3] = 0x33333333;
	demoData[4] = 0x99999999;
	demoData[5] = 0x55555555;
	demoData[6] = 0x42424242;
	demoData[7] = 0xcccccccc;
	
	
	int our_input_fifo_filestream = -1;
  
	bcm2835_init();

    // open fifo
    printf("Process %d opening FIFO %s\n", getpid(), OUR_INPUT_FIFO_NAME);
	our_input_fifo_filestream = open(OUR_INPUT_FIFO_NAME, (O_WRONLY|O_NONBLOCK));
					//Possible flags:
					//	O_RDONLY - Open for reading only.
					//	O_WRONLY - Open for writing only.
					//	O_NDELAY / O_NONBLOCK (same function) - Enables nonblocking mode. When set read requests on the file can return immediately with a failure status
					//											if there is no input immediately available (instead of blocking). Likewise, write requests can also return
					//											immediately with a failure status if the output can't be written immediately.
	if (our_input_fifo_filestream != -1)
		printf("Opened FIFO: %i\n", our_input_fifo_filestream);

    while (1==1)
    {
        write(our_input_fifo_filestream, demoData, 32);
		demoData[1] = demoData[1] + 1;
        delayMicroseconds(13);
    }
    

}