/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.c
 * Author: Max
 *
 * Created on 27. August 2020, 18:59
 */

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "xcorr.c"


/*
 * 
 */

#define ARRAY_LENGTH 10

int writeResult();
int readNumbers();

int main(int argc, char** argv) {
    printf("Hallo Welt\n");
    
    double array[ARRAY_LENGTH] = {0};
    array[2] = -3.5789;
    
    writeResult(array, ARRAY_LENGTH);
    
    double resultArray[ARRAY_LENGTH] = {0};
    readNumbers(resultArray, ARRAY_LENGTH);
     printf("Test\n");
    printf("%lf\n", resultArray[2]);
    
      
    printf("Test");
    
    xcorr(array,array,5);
    

    return (EXIT_SUCCESS);
}



// Source of crosscorrelation Function
/*void xcorr(double* x, double* y, int n){
    int i,j;
    double mx,my,sx,sy,sxy,denom,r;
   
    /* Calculate the mean of the two series x[], y[] 
    mx = 0;
    my = 0;   
    for (i=0;i<n;i++) {
       mx += x[i];
       my += y[i];
    }
    mx /= n;
    my /= n;

    /* Calculate the denominator 
    sx = 0;
    sy = 0;
    for (i=0;i<n;i++) {
       sx += (x[i] - mx) * (x[i] - mx);
       sy += (y[i] - my) * (y[i] - my);
    }
    denom = sqrt(sx*sy);

    /* Calculate the correlation series 
    int maxdelay = 20; // Sould be set as low as possibel in correlation to the maximum possible delay between two mics
    int delay = 0;
    
    for (delay=-maxdelay;delay<maxdelay;delay++) {
       sxy = 0;
       for (i=0;i<n;i++) {
          j = i + delay;
          if (j < 0 || j >= n)
             continue;
          else
             sxy += (x[i] - mx) * (y[j] - my);
         /* Or should it be (?)
         if (j < 0 || j >= n)
            sxy += (x[i] - mx) * (-my);
         else
            sxy += (x[i] - mx) * (y[j] - my);
         
      }
      r = sxy / denom;
      
      /* r is the correlation coefficient at "delay" 

    }
}*/


/*
                 HELPFUNCTIONS
 */ 

// function to write data into file
int writeResult(double* array, int length) {
   FILE * fp;
   int i;
   /* open the file for writing*/
   fp = fopen ("/home/pi/Documents/text.txt","w");
 
   /* write 10 lines of text into the file stream*/
   for(i = 0; i < length;i++){
       fprintf (fp, "%lf\n",array[i]);
   }
 
   /* close the file*/  
   fclose (fp);
   return 0;
}

// fuction to read data from file
int readNumbers(double* numberArray, int length){
    FILE *myFile;
    myFile = fopen("/home/pi/Documents/text.txt", "r");

   
    int i;

    for (i = 0; i < length; i++)
    {
        fscanf(myFile, "%lf", &numberArray[i]);
    }

    fclose(myFile);

    return 0;
}