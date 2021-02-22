clc;
clear all;
close all;

% read files
mic0 = csvread('mic0.csv');
mic1 = csvread('mic1.csv');
mic2 = csvread('mic2.csv');
mic3 = csvread('mic3.csv');
mic4 = csvread('mic4.csv');
mic5 = csvread('mic5.csv');

%plot Arrays
figure();
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

% points must be precalculated
anderereDOAAlgorithmus;

% calc all relavant xcorrelations
a1 = xcorr(mic0,mic1,20);
a2 = xcorr(mic0,mic2,20);
a3 = xcorr(mic0,mic3,20);
a4 = xcorr(mic0,mic4,20);
a5 = xcorr(mic0,mic5,20);
b1 = xcorr(mic1,mic2,20);
b2 = xcorr(mic1,mic3,20);
b3 = xcorr(mic1,mic4,20);
b4 = xcorr(mic1,mic5,20);
c1 = xcorr(mic2,mic3,20);
c2 = xcorr(mic2,mic4,20);
c3 = xcorr(mic2,mic5,20);
d1 = xcorr(mic3,mic4,20);
d2 = xcorr(mic3,mic5,20);
e1 = xcorr(mic4,mic5,20);



% test, ob der Algorithmus hier klappt
sum = 0;
MAX_DELAY = 10;
n = 1064;
testResult = zeros(1,20);
for delay=-MAX_DELAY:MAX_DELAY-1
   sum = 0;
   for position = 1:1064
      positionInY = position + delay;
      if ((positionInY <= 0) || (positionInY > n))
         continue
      else
         sum = sum + mic1(position)* mic0(positionInY);
         %fprintf("%d %d\n", position, positionInY);
      end
   end
   testResult(delay+MAX_DELAY+1)= sum;
end

% figure();
% plot(testResult);
% hold on;
% plot(a1);
% legend("c", "matlab");
% hold off;


% define what fits best
result = zeros(360,1);
for angle = 1:360
    result(angle) = a1(sampleDiff(1,angle)+21) + a2(sampleDiff(2,angle)+21)+ a3(sampleDiff(3,angle)+21)+ a4(sampleDiff(4,angle)+21)+ a5(sampleDiff(5,angle)+21)+ b1(sampleDiff(6,angle)+21)+ b2(sampleDiff(7,angle)+21)+ b3(sampleDiff(8,angle)+21)+ b4(sampleDiff(9,angle)+21)+ c1(sampleDiff(10,angle)+21)+ c2(sampleDiff(11,angle)+21)+ c3(sampleDiff(12,angle)+21)+ d1(sampleDiff(13,angle)+21)+ d2(sampleDiff(14,angle)+21)+ e1(sampleDiff(15,angle)+21);
end

figure();
theta = 1:360;
polarplot(theta*pi/180,result);
hold on;
[value,position] = max(result);
polarplot(position*pi/180,value,'o');
hold off;

figure();
theta = 1:360;
plot(theta,result);
hold on;
[value,position] = max(result);
plot(position,value,'o');
hold off;6