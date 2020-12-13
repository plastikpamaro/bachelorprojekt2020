info= audioinfo('Colt1911gunfiresoundeffect.mp3');
fs = info.SampleRate;
nch = info.NumChannels;
for ii=4.5
    %xx=audioread('testAudio.m4a',[1 2226944]);
    xx=audioread('Colt1911gunfiresoundeffect.mp3',[1 234368]);
    figure(1),plot(xx)
    title(sprintf('%d',ii))
    drawnow
end

%% neuer abschnitt
st=128; %step size
fd=fs/st; %resulting sampling frequency
nn=(size(xx,1)-1024)/st; %number of samples in output vector
Y1=zeros(nn,1); %result vector 1
Y2=Y1; %reszlt vector 2

N=(3:256)'; %frequency bins to use (always ignore bin 1 or DC)
for jj=1:nn
    % if mod(jj,1000)==0, jj, end
    j1=1+(jj-1)*st;
    j2=j1+1023;
    uu=xx(j1:j2,1);%.*hann(1024);
    yy=fft(uu,1024);
    vv=(abs(yy(N)));
    Y1(jj)=sum(vv.*(N-1))/sum(vv); %centroid
    Y2(jj)=sum(vv.^2); %intensity
end
n2=100;
Y3=filter(ones(2*n2,1)/(2*n2),1,[Y2(1)*ones(n2,1);Y2]); Y3(1:n2)=[];
Y4=filter(ones(2*n2,1)/(2*n2),1,[Y1(1)*ones(n2,1);Y1]); Y4(1:n2)=[];
SNR1=10*(Y4./Y1-1);
SNR2=(Y2./Y3-1);
figure(2),plot((1:nn)/fd,SNR1,(1:nn)/fd,SNR2)
figure(4),plot(Y1)
figure(5),plot(Y2)