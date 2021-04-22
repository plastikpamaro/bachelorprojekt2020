    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   fft.h
 * Author: Max
 *
 * Created on 13. Oktober 2020, 10:22
 */

#ifndef FFT_H
#define FFT_H

#ifdef __cplusplus
extern "C" {
#endif

// bibs    
#include <complex.h>
 
// definitions   
#ifndef M_PI
#define M_PI 3.14159265358979324
#endif
typedef double _Complex cplx;   

// functions
void _fft(cplx buf[], cplx out[], int n, int step);
void fft(cplx buf[], int n);
    
#ifdef __cplusplus
}
#endif

#endif /* FFT_H */
