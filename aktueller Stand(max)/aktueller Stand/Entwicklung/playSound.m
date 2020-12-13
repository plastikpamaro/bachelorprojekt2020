Fs = 24000;
T = 1/Fs;
L = 205000;
t = (0:L-1)*T;
X = d300;
%soundsc(X, Fs);
plot(1000*t(1:200),X(1:200));
xlabel('t (milliseconds)');
ylabel('X(t)');

Y = fft(X);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

