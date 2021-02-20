#include <stdio.h>
#include <bcm2835.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>
#include <time.h>   
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>



#define	TRUE	(1==1)
#define	FALSE	(!TRUE)

#define OUR_INPUT_FIFO_NAME "/tmp/my_fifo"
#define BYTES_PER_CHANNEL	4			//because of 24 Bit data and the way data is send (it is shifted and spread over 4 Bytes)
#define NUM_MICROPHONES		6
//#define Debug

uint32_t convertFrom8To24 (uint8_t dataFirst, uint8_t dataSecond, uint8_t dataThird, uint8_t dataForth) {
    uint32_t dataAll = 0x00000000;

    //dataAll = (dataFirst<<18) | (dataSecond<<10) | (dataThird<<2) | (dataForth>>6);
	dataAll = (dataFirst<<17) | (dataSecond<<9) | (dataThird<<1) | (dataForth>>7);
    return dataAll;
}


int main (int argc, char** argv){
	// pre initiatlisation stuff
	printf("pre init \n");
	
	uint32_t ii=0, jj=0, now;
	uint64_t start_time;
	uint8_t data[BYTES_PER_CHANNEL*NUM_MICROPHONES] = {0};		// 8 is highest possible TDM mode
	int32_t data_channel[NUM_MICROPHONES+1] = {0};									// finished data
	
	
	printf("init done\n");
	
	
	
    printf("configure hardware\n");
	// check for GPIO interface init
	if (!bcm2835_init()){
		printf("bcm2835_init failed. Are you running as root?\n");
		return 1;
	}

    // init input for clock signal
    bcm2835_gpio_fsel(RPI_BPLUS_GPIO_J8_40,BCM2835_GPIO_FSEL_INPT); // pin as input
	bcm2835_gpio_set_pud(RPI_BPLUS_GPIO_J8_40, BCM2835_GPIO_PUD_DOWN); // pulldown

    // init SPI
	bcm2835_spi_begin();
	bcm2835_spi_setBitOrder(BCM2835_SPI_BIT_ORDER_MSBFIRST);    // The default
	bcm2835_spi_setDataMode(BCM2835_SPI_MODE1);                 // The default
	bcm2835_spi_setClockDivider(BCM2835_SPI_CLOCK_DIVIDER_32);	// 128	= 1.953125MHz
																// 64	= 3,9MHz
																// 32	= 7.8125MHz
																// 16	= 15.625MHz <-
																// 8	= 31.25MHz
																// 4	= 62.5MHz
																// 2	= 125MHz (fastest possible)
	bcm2835_spi_chipSelect(BCM2835_SPI_CS0);                    // The default
	bcm2835_spi_setChipSelectPolarity(BCM2835_SPI_CS0 , LOW);   // the default
	
	// bcm2835_gpio_fsel(RPI_BPLUS_GPIO_J8_11,BCM2835_GPIO_FSEL_OUTP);
	// bcm2835_gpio_clr(RPI_BPLUS_GPIO_J8_11);


	printf("hardware configuration done\n");
	
	printf("configure pipe\n");
	int our_input_fifo_filestream = -1;
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
	printf("pipe configuratuion done\n");
	
	
	// EIGENTLICHE AUFNAHME
	printf("MSM-Aufnahme wird gestartet...\n\n");
	
	start_time = bcm2835_st_read();
	while (1 == 1){
		if(bcm2835_gpio_lev(RPI_BPLUS_GPIO_J8_40)){ //wait for clock signal

            /* 
            // delay if needed
            int didid = 2;
			for (int i=0; i<10; i++){
				didid = (didid + 2);
			} */

            // Request Data from MSM-Module
            bcm2835_spi_transfern(data, BYTES_PER_CHANNEL*NUM_MICROPHONES);
			// get timestamp
			data_channel[0] = bcm2835_st_read() - start_time;
			
			// convert data			
			jj = 0;
			for(ii=0; ii<(NUM_MICROPHONES); ii++){
				data_channel[ii+1] = convertFrom8To24(data[jj], data[jj+1], data[jj+2], data[jj+3]);
				jj += BYTES_PER_CHANNEL;
			}
			
			
			//write data to fifo
            write(our_input_fifo_filestream, data_channel, (NUM_MICROPHONES+1)*4);
			
            #ifdef DEBUG
            // output on console to see errors
            printf("%02x", data[0]);
            for(ii=1; ii<(BYTES_PER_CHANNEL*NUM_MICROPHONES); ii++){
                printf(",");
                printf("%02x", data[ii]);
            }
            printf("\n");
            #endif
        
        }
	}
}