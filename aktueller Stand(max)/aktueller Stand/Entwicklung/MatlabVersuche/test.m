result = zeros(1,1064);
mic2Corr = zeros(1,1064);
for i = 3:1064
%     result(i) = time(i)-time(i-1);
    if mic4(i) < 5000000
        mic2Corr(i) = mic4(i);
    else
        mic2Corr(i) = (mic4(i-1)+mic4(i+1)+mic4(i-2)+mic4(i+2))/4;
    end
end
% mean(result)
% min(result)
% max(result)
figure(3);
plot(mic2Corr);

% fs = 24000
% f_tp = 10000
% [b a] = butter(5,f_tp/(0.5*fs),'low'); % Koeffizienten der Übertragungsfunktion, f_tp ist die Grenzfrequenz, fs die Abtastfrequ., Butterworthfilter
% x = filter(b,a,mic1); %x ist das Signal
% figure(1);
% plot(x);
% figure(2);
% freqz(b,a)
% soundsc(mic2Corr,24000)
