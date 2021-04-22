/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   cameraControl.cpp
 * Author: Philipp
 * 
 * Created on 25. Februar 2021, 14:32
 */

#include "cameraControl.h"
#include <ctime>
#include <fstream>
#include <iostream>
#include <raspicam/raspicam.h>
#include <unistd.h>


using namespace std;

cameraControl::cameraControl() {
    //Open camera 
    cout<<"Opening Camera..."<<endl;
    if ( !Camera.open()) {
        cerr<<"Error opening camera"<<endl;
    }
    //wait a while until camera stabilizes
    cout<<"Sleeping for 3 secs"<<endl;
    usleep(3);
}

void cameraControl::takePicture() {
    Camera.grab();
    //allocate memory
    unsigned char *data=new unsigned char[  Camera.getImageTypeSize ( raspicam::RASPICAM_FORMAT_RGB )];
    //extract the image in rgb format
    Camera.retrieve ( data,raspicam::RASPICAM_FORMAT_IGNORE );//get camera image
    //save
    std::ofstream outFile ( "teures_Foto.ppm",std::ios::binary );
    outFile<<"P6\n"<<Camera.getWidth() <<" "<<Camera.getHeight() <<" 255\n";
    outFile.write ( ( char* ) data, Camera.getImageTypeSize ( raspicam::RASPICAM_FORMAT_RGB ) );
    cout<<"saved as 'teures_Foto.ppm'"<<endl;
    //free resrources    
    delete data;
}

void cameraControl::editPicture(int result) {
    if(result >= 320 && result < 330){
        segment = 1;
    }else if(result >= 330 && result < 340){
        segment = 2;
    }else if(result >= 340 && result < 350){
        segment = 3;
    }else if(result >= 350 && result < 360){
        segment = 4;
    }else if(result >= 0 && result < 10){
        segment = 5;
    }else if(result >= 10 && result < 20){
        segment = 6;
    }else if(result >= 20 && result < 30){
        segment = 7;
    }
    cout<<"erkanntes Segment:"<<segment<<endl;

    
    switch(segment){
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
    }

}


cameraControl::cameraControl(const cameraControl& orig) {
}

cameraControl::~cameraControl() {
}

