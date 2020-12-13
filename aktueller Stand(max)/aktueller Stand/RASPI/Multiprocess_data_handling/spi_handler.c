#include <stdio.h>
#include <bcm2835.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>
#include <time.h>  


uint32_t convertFrom8To24special (uint8_t dataFirst, uint8_t dataSecond, uint8_t dataThird, uint8_t dataForth) {
    uint32_t dataAll = 0x00000000;

    dataAll = (dataFirst<<18) | (dataSecond<<10) | (dataThird<<2) | (dataForth>>6);
    return dataAll;
}

int main(void){
	printf("Initialisation\n");
	
	uint8_t buffa[8] = {0}; // raw recived data
	uint8_t buffb[8] = {0};
	uint8_t buffc[8] = {0};
	uint8_t buffd[8] = {0};
	uint32_t data[8] = {0}; // converted data
	
	bcm2835_init();
	bcm2835_gpio_fsel(RPI_BPLUS_GPIO_J8_40,BCM2835_GPIO_FSEL_INPT);
	bcm2835_gpio_set_pud(RPI_BPLUS_GPIO_J8_40, BCM2835_GPIO_PUD_DOWN); // Input Pin fpr external timer
	
	bcm2835_spi_begin();
	bcm2835_spi_setBitOrder(BCM2835_SPI_BIT_ORDER_MSBFIRST);    // The default
	bcm2835_spi_setDataMode(BCM2835_SPI_MODE1);                 // The default
	bcm2835_spi_setClockDivider(BCM2835_SPI_CLOCK_DIVIDER_16);
	
	printf("Strat recording data\n");
	while(1==1){
		if(bcm2835_gpio_lev(RPI_BPLUS_GPIO_J8_40)){
			int didid = 2;
			for (int i=0; i<10; i++){
				didid = (didid + 2);
			}
			bcm2835_spi_transfern(buffa, 8);
			bcm2835_spi_transfern(buffb, 8);
			bcm2835_spi_transfern(buffc, 8);
			bcm2835_spi_transfern(buffd, 8);
			
			data[0] = convertFrom8To24special(buffa[0],buffa[1],buffa[2],buffa[3]);
			data[2] = convertFrom8To24special(buffb[0],buffb[1],buffb[2],buffb[3]);
			data[4] = convertFrom8To24special(buffc[0],buffc[1],buffc[2],buffc[3]);
			data[6] = convertFrom8To24special(buffd[0],buffd[1],buffd[2],buffd[3]);
			
			data[1] = convertFrom8To24special(buffa[4],buffa[5],buffa[6],buffa[7]);
			data[3] = convertFrom8To24special(buffb[4],buffb[5],buffb[6],buffb[7]);
			data[5] = convertFrom8To24special(buffc[4],buffc[5],buffc[6],buffc[7]);
			data[7] = convertFrom8To24special(buffd[4],buffd[5],buffd[6],buffd[7]);
			
			
		}
		
	}
}
