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
#include "xcorr.h"


/*
 * 
 */

#define DATA_LENGTH 1024
#define MAX_DELAY   20
#define RESULT_ARRAY 2 * MAX_DELAY

#define FS 44000 //needs to be the sample freq
#define DELTA_T 0.0000272727

int writeResult();
int readNumbers();

int main(int argc, char** argv) {
    /*int i = 0;
    double arrayA[10] = {0};
    double arrayB[10] = {0};
    
    for (i=0; i<10; i++){
        arrayA[i] = i;
        arrayB[i] = i + 5;
    }
    
    xcorr(arrayA, arrayB, 10);*/
    int length = DATA_LENGTH;
    double arrayA[DATA_LENGTH] = {0};
    double arrayB[DATA_LENGTH] = {0};
    
    double resultData[RESULT_ARRAY] = {0};
    
    char patha[] = "/home/pi/Documents/Studienarbeit/xcoorTest/b_data.txt";
    char pathb[] = "/home/pi/Documents/Studienarbeit/xcoorTest/c_data.txt";
    char pathc[] = "/home/pi/Documents/Studienarbeit/xcoorTest/result.txt";
    
    printf("open data\n");
    readNumbers(arrayA,length, patha);
    readNumbers(arrayB,length, pathb);
    printf("start\n");
    //xcorr(arrayA,arrayB,length,resultData,MAX_DELAY);
    //int index = maxInArray(resultData,RESULT_ARRAY);
    int index = getDelay(arrayA,arrayB,length);
    printf("done\n");
    printf("Zeitliche Verschiebung um %d samples.", index);
    printf("saving ");
    //writeResult(resultData, RESULT_ARRAY, pathc);
    printf("done\n");
    printf("%.9lf",DELTA_T);
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
int writeResult(double* array, int length, char* path) {
   FILE * fp;
   int i;
   /* open the file for writing*/
   fp = fopen (path,"w");
 
   /* write 10 lines of text into the file stream*/
   for(i = 0; i < length;i++){
       fprintf (fp, "%lf\n",array[i]);
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