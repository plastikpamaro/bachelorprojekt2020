%% Filter Design
clc;
clear;
close all;

f_s = 8000;

f = [0 1000 2500 2800 4500 5500 7000 8000];
f = f./f_s;
a = [0 0 0 14 0 0 0 0];

for i=3:1:30
    b = firpm(i,f,a);

    [h,w] = freqz(b,1,512);
    plot(f,a,w/pi,abs(h));
    legend('Ideal','firpm Design');
    xlabel('Radian Frequency (\omega/\pi)');
    ylabel('Magnitude');
    title(['Order ', num2str(i)]);
    pause;
end;

%% desired filter
clc;
clear all;
close all;

f = [0 1000 2500 2800 4500 5500 6500 8000];
a = [-1 0 3 0 -14 -4 -18 -3]; %in dB
a_inv = -a;
zero = zeros(1,8);

plot(f, a, f, a_inv, f, zero, 'k');
hold on;
plot([1000 1000], [-20 20], 'k');
plot([2800 2800], [-20 20], 'k');
plot([5500 5500], [-20 20], 'k');
grid on;
xlabel('frequency / Hz');
ylabel('amplitude / dB');
legend('linearized fft 6mm membrane', 'inverse \rightarrow desired filter');
hold off;

%% Filter Teilband 1

f_s = 8000;

f_1 = [0 1000 7000 8000];
f_1 = f_1./f_s;
a_1 = [1 0 0 0];
ord_1 = 6; % 6 ist die beste Ordnung

b_1 = firpm(ord_1,f_1,a_1);

[h_1,w_1] = freqz(b_1,1,512);
plot(f_1,a_1,w_1/pi,db(h_1));
legend('Ideal','firpm Design');
xlabel('Radian Frequency (\omega/\pi)');
ylabel('Magnitude');
title(['N = ', num2str(ord_1)]);

%% Filter 1

clc;
clear;
close('all');
Fs_in = 48000;

% Fs at output side is Fs at input side:
Fs_out = Fs_in;

% frequency vector, until Fs/2 !!
freq=(1:4999)/10000;

N_FIR = 6;
fo = [0 1000 7000 8000]./(Fs_in/2);
mo = [1 0 0 0];
b_fir_remez = firpm(N_FIR,fo,mo);

% round them to 16 bits
b_fir_remez = round(b_fir_remez*32768)/32768;
b_fir_remez_16bit = b_fir_remez*32768;
hz_fir_remez = freqz(b_fir_remez,1,2*pi*freq);
fprintf(' N of FIR = %d\n',N_FIR);
figure(1);
plot(freq*Fs_in,db(hz_fir_remez));
hold on;
grid on;
plot([0 1000], [1 0], 'k');
xlim([0 6000]);
ylim([-20 3]);
title(['N = ', num2str(N_FIR)])
hold off;

%% Filter Teilband 2

clc;
clear;
close('all');
Fs_in = 48000;

% Fs at output side is Fs at input side:
Fs_out = Fs_in;

% frequency vector, until Fs/2 !!
freq=(1:4999)/10000;

% design FIR filter:
% Use N_FIR=14, thus 15 coeffs
fpass_1 = 1000;
fstop_1 = 2000;
fstop_2 = 3000;
fpass_2 = 3450;
% fprintf(' edge frequency of stop-band is %6.2f Hz\n',fstop);
% fpass = inputs('desired edge frequency of pass-band',fpass);
delta_pass = 0.01; %inputs('ripple in pass-band',0.01);
delta_stop_dB = 0.1; %inputs('Attenuation in stop-band in dB',40);
delta_stop = 10^(-delta_stop_dB/20);

[N_FIR,fo,mo,w] = remezord( [fpass_1 fstop_1 fstop_2 fpass_2], [1 0 1], [delta_pass delta_stop delta_pass], Fs_in );
b_fir_remez = remez(N_FIR,fo,mo,w);

% round them to 16 bits
b_fir_remez = round(b_fir_remez*32768)/32768;
b_fir_remez_16bit = b_fir_remez*32768;
hz_fir_remez = freqz(b_fir_remez,1,2*pi*freq);
fprintf(' N of FIR = %d\n',N_FIR);
figure(1);
plot(freq*Fs_in,db(hz_fir_remez));
hold on;
grid on;
plot([1000 2500], [0 -3], 'k');
plot([2500 2800], [-3 0], 'k');
xlim([0 6000]);
ylim([-20 3]);
title(['N = ', num2str(N_FIR)])
hold off;
% pause
% plot(freq*Fs_in,abs(hz_fir_remez)),grid,

%% neuer Ansatz
close all;

N = [4, 2, 4, 4]; % Ordnung je Teilfilter
gain = [1, -3, 14, 18]; % in dB
centerFreq = [0, 2500, 4500, 6500]./8000;
bandwidth = [1000, 1000, 1000, 1000]./8000;
[B, A] = designParamEQ(N,gain,centerFreq,bandwidth);
SOS = [B',[ones(sum(N)/2,1),A']];
fvtool(SOS);

% es entsteht ein IIR Filter, deswegen a Koeffizienten. Ein FIR hat nur b
% Koeffizienten, da der rekursive Anteil wegfällt

% Ein Filter ist stabil, wenn
% Pole innerhalb des Einheitskreises liegen
% Impulsantwort im endlichen aufsummierbar
% https://ti.tuwien.ac.at/cps/teaching/courses/sigproz/files/DesignFIR.pdf
% https://ti.tuwien.ac.at/cps/teaching/courses/sigproz/files/DesignIIR.pdf


%% erneut neuer Ansatz

% https://www.mathworks.com/help/audio/examples/parametric-equalizer-design.html
close all;
clear all;
clc;

Fs = 16e3;

N1 = 6;
G1 = 1; % dB
CF1 = 0/(Fs/2); % center frequency
BW1 = 200/(Fs/2); % bandwidth of filter

N2 = 2;
G2 = -3; % dB
CF2 = 2500/(Fs/2); % center frequency
BW2 = 200/(Fs/2); % bandwidth of filter

N3 = 2;
G3 = 14; % dB
CF3 = 4500/(Fs/2); % center frequency
BW3 = 500/(Fs/2); % bandwidth of filter

N4 = 2;
G4 = 18; % dB
CF4 = 6500/(Fs/2); % center frequency
BW4 = 500/(Fs/2); % bandwidth of filter

[B1,A1] = designParamEQ(N1,G1,CF1,BW1);
[B2,A2] = designParamEQ(N2,G2,CF2,BW2);
[B3,A3] = designParamEQ(N3,G3,CF3,BW3);
[B4,A4] = designParamEQ(N4,G4,CF4,BW4);

A1 = zeros(size(A1));
A2 = zeros(size(A2));
A3 = zeros(size(A3));
A4 = zeros(size(A4));

BQ1 = dsp.BiquadFilter('SOSMatrix',[B1.',[ones(N1/2, 1),A1.']]);
BQ2 = dsp.BiquadFilter('SOSMatrix',[B2.',[ones(N2/2, 1),A2.']]);
BQ3 = dsp.BiquadFilter('SOSMatrix',[B3.',[ones(N3/2, 1),A3.']]);
BQ4 = dsp.BiquadFilter('SOSMatrix',[B4.',[ones(N4/2, 1),A4.']]);
FC  = dsp.FilterCascade(BQ1,BQ2,BQ3,BQ4);
hfvt = fvtool(BQ1, BQ2, BQ3, BQ4, FC, 'Fs',Fs,'Color','white');
legend(hfvt,'First Filter', 'Second Filter', 'Third Filter', 'Fourth Filter', 'Cascasde');























