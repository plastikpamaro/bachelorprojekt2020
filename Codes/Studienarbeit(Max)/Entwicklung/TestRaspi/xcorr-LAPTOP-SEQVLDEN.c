/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

// Source of crosscorrelation Function
#include <math.h>

void xcorr(double* x, double* y, int n){
    int i,j;
    double mx,my,sx,sy,sxy,denom,r;
   
    /* Calculate the mean of the two series x[], y[] */
    mx = 0;
    my = 0;   
    for (i=0;i<n;i++) {
       mx += x[i];
       my += y[i];
    }
    mx /= n;
    my /= n;

    /* Calculate the denominator */
    sx = 0;
    sy = 0;
    for (i=0;i<n;i++) {
       sx += (x[i] - mx) * (x[i] - mx);
       sy += (y[i] - my) * (y[i] - my);
    }
    denom = sqrt(sx*sy);

    /* Calculate the correlation series */
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
         */
      }
      r = sxy / denom;
      
      /* r is the correlation coefficient at "delay" */

    }
}