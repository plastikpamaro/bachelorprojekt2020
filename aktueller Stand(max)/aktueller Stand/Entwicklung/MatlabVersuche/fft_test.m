fs = 2000;
T = 1/fs;
L = 1024;
x = (0:L-1)*T;

y = sin(2*pi*x*200)+sin(2*pi*500*x)+sin(2*pi*42*x)+sin(2*pi*x*150);

Y = fft(y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

fileID = fopen('input.csv','w');
for i=[1:length(y)]
    fprintf(fileID,'%f\n',y(i));
end
fclose(fileID);


P1 = out1(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = fs*(0:(L/2))/L;
figure(2)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')