/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

#include "utils.h"
#include <stdio.h>


// function to write data into file
int writeResult(double* array, int length, char* path) {
   FILE * fp;
   int i;
   /* open the file for writing*/
   fp = fopen (path,"w");
 
   /* write 10 lines of text into the file stream*/
   for(i = 0; i < length;i++){
       fprintf (fp, "%lf\n",array[i]);
       //fprintf (fp, "%f+%fj\n",creal(array[i]),cimag(array[i]));
   }
 
   /* close the file*/  
   fclose (fp);
   return 0;
}

// fuction to read data from file
int readNumbers(double* numberArray, int length, char* path){
    FILE *myFile;
    myFile = fopen(path, "r");

   
    int i;

    for (i = 0; i < length; i++)
    {
        fscanf(myFile, "%lf", &numberArray[i]);
    }

    fclose(myFile);

    return 0;
}

//shows vomplex numbers
void show(const char * s, cplx buf[]) {
	printf("%s", s);
	for (int i = 0; i < 8; i++)
		if (!cimag(buf[i]))
			printf("%g ", creal(buf[i]));
		else
			printf("(%g, %g) ", creal(buf[i]), cimag(buf[i]));
}