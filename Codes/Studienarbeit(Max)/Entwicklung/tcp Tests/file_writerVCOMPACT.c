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

void main(){

	int our_input_fifo_filestream = -1;
	time_t nowtime;
	struct tm *today; 
	
	
	unsigned int first_time = 1, samples = 1000000, counter = 0;
	uint32_t ii=0, jj=0, sample_cnt_collect=0;
	uint64_t start_time, end_time;
	float samplerate = 0;
	FILE *output_file = 0;
	struct tm *t = 0;

	char buffer [30];
	char date[9];
	

	//--------------------------------------
	//----- CREATE A FIFO / NAMED PIPE -----
	//--------------------------------------
	int result;
	
	bcm2835_init();

	printf("Making FIFO...\n");
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
	

	
	uint32_t rx_buffer[9];		

	while (1==1) {
	//---------------------------------------------
		//----- CHECK FIFO FOR ANY RECEIVED BYTES -----
		//---------------------------------------------
		// Read up to 255 characters from the port if they are there
		
		counter = 0;
       
		
		nowtime = time(NULL);
		t = localtime(&nowtime);
		strftime( buffer, sizeof(buffer), "data_%d%m%y_%H%M%S.audio", t );
		output_file = fopen(buffer, "w");
		
		
		if(output_file == 0){
			fprintf (stderr, "Can't create output file: %s\n", strerror (errno));
			exit (EXIT_FAILURE); 
		}
		
		first_time = 1;
		
		while ( counter < samples){
		
			if (first_time == 1) {
				first_time = 0;
				start_time = bcm2835_st_read();
			}
			
			rx_buffer[8] = bcm2835_st_read() - start_time;
				
			int rx_length = read(our_input_fifo_filestream, (void*)rx_buffer, 32);		//Filestream, buffer to store in, number of bytes to read (max)
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
				fwrite(rx_buffer,4,9,output_file);
				//printf("FIFO %i bytes read : %d\n", rx_length, rx_buffer[0]);
				counter++;
			}
		}
		
		fclose(output_file);
	}
}
