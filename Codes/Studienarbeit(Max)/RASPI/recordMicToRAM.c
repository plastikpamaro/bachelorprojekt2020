#include <stdio.h>
#include <bcm2835.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>
#include <time.h>    


#define	TRUE	(1==1)
#define	FALSE	(!TRUE)


#define BYTES_PER_CHANNEL	4			//because of 24 Bit data and the way data is send (it is shifted and spread over 4 Bytes)
#define NUM_TO_COLLECT		205000      //10 seconds
#define NUM_MICROPHONES		6
//#define Debug

uint32_t convertFrom8To24 (uint8_t dataFirst, uint8_t dataSecond, uint8_t dataThird, uint8_t dataForth) {
    uint32_t dataAll = 0x00000000;

    //dataAll = (dataFirst<<18) | (dataSecond<<10) | (dataThird<<2) | (dataForth>>6);
	dataAll = (dataFirst<<17) | (dataSecond<<9) | (dataThird<<1) | (dataForth>>7);
    return dataAll;
}


int main (int argc, char** argv){
	printf("pre init \n");
	time_t nowtime;
	struct tm *today;  
	char buffer [30];
	char date[9];
	
	unsigned int first_time = 1;
	uint32_t ii=0, jj=0, sample_cnt_collect=0;
	uint64_t start_time, end_time, now[NUM_TO_COLLECT], time_now[NUM_TO_COLLECT];
	uint8_t buff[4] = {0};
	uint8_t data[NUM_TO_COLLECT][BYTES_PER_CHANNEL*NUM_MICROPHONES] = {{0}};		// 8 is highest possible TDM mode
	int32_t data_channel[NUM_MICROPHONES] = {0};									// finished data
	FILE *output_file = 0;
	struct tm *t = 0;
	
	printf("init done\n");

	// Configure measurement according to input parameters
	if (argc < 2) {
        fprintf(stderr, "Usage: %s [-fs SAMPLE_RATE]\nFor help use: %s -h\n\n", argv[0], argv[0]);
    }
	
	while (*argv) {
        if (strcmp(*argv, "-h") == 0) {
			printf("Usage: [-fs SAMPLE_RATE]\n");
			printf("-fs  : rate at which to record samples - has currently no effect\n");
			return 0;
		}
        if (*argv)
            argv++;
    }

	


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
	printf("MSM-Aufnahme wird gestartet...\n\n");

    start_time = bcm2835_st_read();
    
    // collect data
    while(sample_cnt_collect < NUM_TO_COLLECT){ // one file for 10 Seconds

        if(bcm2835_gpio_lev(RPI_BPLUS_GPIO_J8_40)){ //wait for clock signal

            /* 
            // delay if needed
            int didid = 2;
			for (int i=0; i<10; i++){
				didid = (didid + 2);
			} */

            // Request Data from MSM-Module
            bcm2835_spi_transfern(data[sample_cnt_collect], BYTES_PER_CHANNEL*NUM_MICROPHONES);
        

            time_now[sample_cnt_collect] = bcm2835_st_read();
            now[sample_cnt_collect] = time_now[sample_cnt_collect] - start_time;
                    
            #ifdef DEBUG
            // output on console to see errors
            printf("%02x", data[0]);
            for(ii=1; ii<(BYTES_PER_CHANNEL*NUM_MICROPHONES); ii++){
                printf(",");
                printf("%02x", data[sample_cnt_collect][ii]);
            }
            printf("\n");
            #endif
        
            sample_cnt_collect++;
        }
    }
    sample_cnt_collect = 0;
    end_time = bcm2835_st_read();
    printf("recording done\n");
    
    
    //write data to file
    printf("save data to SD card\n");
    while(sample_cnt_collect < NUM_TO_COLLECT){
        
        // first time: create and writing the file
        if(first_time == 1){
            first_time = 0;
            
            // Create Output File according to time
            nowtime = time(NULL);
            t = localtime(&nowtime);
            strftime( buffer, sizeof(buffer), "data_%d%m%y_%H%M%S.txt", t );
            output_file = fopen(buffer, "w");
            
            if(output_file == 0){
                fprintf (stderr, "Can't create output file: %s\n", strerror (errno));
                exit (EXIT_FAILURE); 
            }
    
            fprintf(output_file, "%lu\n",start_time);
            for(ii=0; ii<(NUM_MICROPHONES); ii++){
                fprintf(output_file, "ch%u, ch%u, ", ii,ii+1);
            }
            fprintf(output_file, "us\n");
        }
        
        // convert single byte to 24 bit data
        jj = 0;
		
        for(ii=0; ii<(NUM_MICROPHONES); ii++){
            data_channel[ii] = convertFrom8To24(data[sample_cnt_collect][jj], data[sample_cnt_collect][jj+1], data[sample_cnt_collect][jj+2], data[sample_cnt_collect][jj+3]);
            jj += BYTES_PER_CHANNEL;
        }
                    
        // write file
        for(ii=0; ii<(NUM_MICROPHONES); ii++){
            fprintf(output_file, "%d, ", data_channel[ii]);
        }
        fprintf(output_file, "%lu\n", now[sample_cnt_collect]);
        
        sample_cnt_collect++;
        
    }
    sample_cnt_collect = 0;
    first_time = 1;
    
    fclose(output_file);
    output_file = 0;
    t = 0;
    printf("Data saved to file\n");

		
	
    // close SPI and GPIO
	//bcm2835_spi_end();
	//bcm2835_close();
	
	return 0;
}
