clc
clear all;
close all;

load Test3.csv
csv = Test3;

fs = 24000;
bits = 24;


%% nur bei 1 oder 2 channel

%soundsc(csv(:,2),fs,24);

%% plotten von 5 mikros

figure(1)
for k1 = 1:6
    subplot(6,1,k1)
    plot(csv(:,k1));
    ylim([-8e6 8e6])
    xlim([0 2.05e5])
    ylabel('Messwert /AU','Fontsize', 18);
    title(['\fontsize{24}Mikrofon ',num2str(k1)]);
%     set(get(gca,'title'),'Position',[20000 4500000 15])
end
xlabel('Messpunkt /Samples','Fontsize', 24)
%% 
% figure(2)
% for k2 = 1:6
% plot(csv(:,k2));hold on
% end
% %axis([5.94e4 5.97e4 -5e6 14e6]);
% 
% %%
% figure(3)
% plot(csv(:,1));

