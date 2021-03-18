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
    Camera.retrieve ( data,raspicam::RASPICAM_FORMAT_RGB );//get camera image
    //save
    std::ofstream outFile ( "raspicam_image.ppm",std::ios::binary );
    outFile<<"P6\n"<<Camera.getWidth() <<" "<<Camera.getHeight() <<" 255\n";
    outFile.write ( ( char* ) data, Camera.getImageTypeSize ( raspicam::RASPICAM_FORMAT_RGB ) );
    cout<<"Image saved at raspicam_image.ppm"<<endl;
    //free resrources    
    delete data;
}


cameraControl::cameraControl(const cameraControl& orig) {
}

cameraControl::~cameraControl() {
}

