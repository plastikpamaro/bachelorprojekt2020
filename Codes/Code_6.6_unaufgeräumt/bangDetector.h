/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   bangDetector.h
 * Author: Max
 *
 * Created on 16. Oktober 2020, 14:50
 */

#ifndef BANGDETECTOR_H
#define BANGDETECTOR_H

#define FFTLENGTH   1024
#define FFTLENGTHMEMORY 512;

class bangDetector{
private:
    double fftResultOld[512] = {0};
    double fftResultNew[512] = {0};
    double oldCentroid = 0;
    int fftLengthInt = FFTLENGTH;
    double energyDiff = 0;
    
    
public:
    //constructor
    bangDetector();
    
    //deconstructor
    ~bangDetector();
    
    //functions
    void calcEnergy(int startBin, int endBin);
    void calcEnergyDiff();
    void calcEnergyAngle();
    
    void calcCentroid();
    void calcCentroidDiff();
    void calcCentroidAngle();
    
    int checkForBang(double inputData[]);
    void processFFT(double inputData[]);
};


#endif /* BANGDETECTOR_H */

