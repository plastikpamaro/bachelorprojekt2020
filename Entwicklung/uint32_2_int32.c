#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <inttypes.h>

//16776817, 16776817

int32_t convertToSigned(uint32_t inputUnsigned){
    // converting unsigned to singed
    int32_t signedValue = inputUnsigned << 8;
    return (signedValue >> 8);    
}

int main(void){
	FILE * dataIn;
	FILE * dataOut;
	dataIn = fopen("testmessung_22_02.txt", "r");
	dataOut = fopen("ConvertedTestmessung_22_02.txt", "w");
	uint32_t rawMic0 = 0;
	uint32_t rawMic1 = 0;
	uint32_t rawMic2 = 0;
	uint32_t rawMic3 = 0;
	uint32_t rawMic4 = 0;
	uint32_t rawMic5 = 0;
	int time = 0;
	int32_t converted0 = 0;
	int32_t converted1 = 0;
	int32_t converted2 = 0;
	int32_t converted3 = 0;
	int32_t converted4 = 0;
	int32_t converted5 = 0;
	int c = 0;

	if(dataOut == NULL || dataIn == NULL){
		return 1;
	} 
	while((c=fgetc(dataIn)) != EOF){
		fscanf(dataIn, "%u, %u, %u, %u, %u, %u, %i", &rawMic0, &rawMic1, &rawMic2, &rawMic3, &rawMic4, &rawMic5, &time);
		converted0 = convertToSigned(rawMic0);
		converted1 = convertToSigned(rawMic1);
		converted2 = convertToSigned(rawMic2);
		converted3 = convertToSigned(rawMic3);
		converted4 = convertToSigned(rawMic4);
		converted5 = convertToSigned(rawMic5);
		fprintf(dataOut, "%i; %i; %i; %i; %i; %i\n", converted0, converted1, converted2, converted3, converted4, converted5);
	}
	fclose(dataIn);
	fclose(dataOut);

	return 0;
}