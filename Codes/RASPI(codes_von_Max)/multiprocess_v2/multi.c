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

uint32_t convertFrom8To24special (uint8_t dataFirst, uint8_t dataSecond, uint8_t dataThird, uint8_t dataForth) {
    uint32_t dataAll = 0x00000000;

    dataAll = (dataFirst<<18) | (dataSecond<<10) | (dataThird<<2) | (dataForth>>6);
    return dataAll;
}

void main(){
	int fd[2], fd1, n;
   pid_t pid;
   char puffer[PIPE_BUF];
   
   /*Wir erstellen eine Pipe*/
   if (pipe (fd) < 0) {
      perror ("pipe");
      exit (EXIT_FAILURE);
   }
   /*Wir erzeugen einen neuen Prozess*/
   if ((pid = fork ()) < 0) {
      perror ("fork");
      exit (EXIT_FAILURE);
   }
   else if (pid > 0) {   /*Elternprozess */
      close (fd[0]);   /*Leseseite schließen */
      
	    uint8_t buffa[8] = {0}; // raw recived data
	uint8_t buffb[8] = {0};
	uint8_t buffc[8] = {0};
	uint8_t buffd[8] = {0};
	uint32_t data[6] = {0}; // converted data
	
	
	int our_input_fifo_filestream = -1;
  
	bcm2835_init();
	bcm2835_gpio_fsel(RPI_BPLUS_GPIO_J8_40,BCM2835_GPIO_FSEL_INPT);
	bcm2835_gpio_set_pud(RPI_BPLUS_GPIO_J8_40, BCM2835_GPIO_PUD_DOWN); // Input Pin fpr external timer
	
	bcm2835_spi_begin();
	bcm2835_spi_setBitOrder(BCM2835_SPI_BIT_ORDER_MSBFIRST);    // The default
	bcm2835_spi_setDataMode(BCM2835_SPI_MODE1);                 // The default
	bcm2835_spi_setClockDivider(BCM2835_SPI_CLOCK_DIVIDER_16);

 
	printf("Strat recording \n");
    while (1==1)
    {	
		if(bcm2835_gpio_lev(RPI_BPLUS_GPIO_J8_40)){
			//int didid = 2;
			//for (int i=0; i<15; i++){
			//	didid = (didid + 2);
			//}
			bcm2835_spi_transfern(buffa, 8);
			bcm2835_spi_transfern(buffb, 8);
			bcm2835_spi_transfern(buffc, 8);
			//bcm2835_spi_transfern(buffd, 8);
			
			data[0] = convertFrom8To24special(buffa[0],buffa[1],buffa[2],buffa[3]);
			data[2] = convertFrom8To24special(buffb[0],buffb[1],buffb[2],buffb[3]);
			data[4] = convertFrom8To24special(buffc[0],buffc[1],buffc[2],buffc[3]);
			//data[6] = convertFrom8To24special(buffd[0],buffd[1],buffd[2],buffd[3]);
			
			data[1] = convertFrom8To24special(buffa[4],buffa[5],buffa[6],buffa[7]);
			data[3] = convertFrom8To24special(buffb[4],buffb[5],buffb[6],buffb[7]);
			data[5] = convertFrom8To24special(buffc[4],buffc[5],buffc[6],buffc[7]);
			//data[7] = convertFrom8To24special(buffd[4],buffd[5],buffd[6],buffd[7]);
			
			write(fd[1], data, 24);
			
		}
        
    }
	  
	  

   }
   else {        /*Kindprozess */
      close (fd[1]);   /*Schreibseite schließen */
	  
	  
	  
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
	
	
	bcm2835_init();


	
	

	
	uint32_t rx_buffer[8];		

	while (1==1) {
	//---------------------------------------------
		//----- CHECK FIFO FOR ANY RECEIVED BYTES -----
		//---------------------------------------------
		// Read up to 255 characters from the port if they are there
		
		counter = 0;
       
		
		nowtime = time(NULL);
		t = localtime(&nowtime);
		strftime( buffer, sizeof(buffer), "data_%d%m%y_%H%M%S.txt", t );
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
			
			end_time = bcm2835_st_read() - start_time;
				
			int rx_length = read(fd[0], (void*)rx_buffer, 32);		//Filestream, buffer to store in, number of bytes to read (max)
			if (rx_length <= 0)
			{
				//An error occured (this can happen)
				//printf("FIFO Read error\n");
			}
			else
			{	
				fprintf(output_file, "%x,%x,%x,%x,%x,%x,%lu\n", rx_buffer[0],rx_buffer[1],rx_buffer[2],rx_buffer[3],rx_buffer[4],rx_buffer[5], end_time);
				//printf("FIFO %i bytes read : %d\n", rx_length, rx_buffer[0]);
				counter++;
			}
		}
		
		fclose(output_file);
	}
	
	  
	
   }
   exit (EXIT_SUCCESS);
}