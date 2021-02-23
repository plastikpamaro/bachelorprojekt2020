clc
clear all;
close all;
load testmessung_22_02_signed.csv
soundsc(testmessung_22_02_signed,24000,24);
plot(testmessung_22_02_signed);