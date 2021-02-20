% read files
mic0 = csvread('mic0.csv');
mic1 = csvread('mic1.csv');
mic2 = csvread('mic2.csv');
mic3 = csvread('mic3.csv');
mic4 = csvread('mic4.csv');
mic5 = csvread('mic5.csv');

%plot Arrays
figure(1);
title('Sound from each microphone')
subplot(6,1,1);
plot(mic0);
subplot(6,1,2);
plot(mic1);
subplot(6,1,3);
plot(mic2);
subplot(6,1,4);
plot(mic3);
subplot(6,1,5);
plot(mic4);
subplot(6,1,6);
plot(mic5);


%%Define constant
M = 5; %number of mics in circle
phi = (2*pi)/M;

N = 6; %number of mics
alpha = phi; %angle between 2 mics
r = 0.062155; %array radius
win = 1024; %window size
c = 340; %speed of sound

D = 2; %Speaker Distance in m

plotPositions = 1; % 1 if plot of mic & speaker needed



fs = 24000;


%calc matrix (can be precalculated to save processing time)
 A = [[0, 1],
        [sin(phi), cos(phi)],
        [sin(2*phi), cos(2*phi)],
        [sin(3*phi), cos(3*phi)],
        [sin(4*phi), cos(4*phi)],
        [-cos(phi/2), sin(phi/2)],
        [-cos(2*phi/2), sin(phi)],
        [-cos(3*phi/2), sin(1.5*phi)],
        [-cos(4*phi/2), sin(2*phi)],
        ];
    

    
Aganz = (r/c)*A;

P = (inv((transpose(Aganz)*Aganz))*transpose(Aganz));




% BEgin of DOA Claculation
correlation = rand(9,2127);
correlation(1,:) = xcorr(mic0,mic1 ,'normalized');
correlation(2,:) = xcorr(mic2,mic0 ,'normalized');
correlation(3,:) = xcorr(mic3,mic0 ,'normalized');
correlation(4,:) = xcorr(mic4,mic0 ,'normalized');
correlation(5,:) = xcorr(mic5,mic0 ,'normalized');
correlation(6,:) = xcorr(mic1,mic2 ,'normalized');
correlation(7,:) = xcorr(mic1,mic3 ,'normalized');
correlation(8,:) = xcorr(mic1,mic4 ,'normalized');
correlation(9,:) = xcorr(mic1,mic5 ,'normalized');


[max_val, max_pos] = max(correlation');
max_pos = (max_pos-1024);
max_pos = max_pos';

delta_t = max_pos *(1/fs); %calc delay of each value

ergebnis = P*delta_t;

ergebnis_winkel = (atan2(ergebnis(1),(ergebnis(2)))*180/pi)