
WaveControl = data1.Wave;
WaveShock = data2.Wave;
auxC = std(WaveControl,1);
auxS = std(WaveShock,1);
figure; plot(auxS(1,:,1))
hold on; plot(auxS(1,:,10),'r');plot(auxS(1,:,20),'k');plot(auxS(1,:,30),'g');
plot(auxS(1,:,40),'c')
title('Shock Channels')
legend('Epoch 1','Epoch 10','Epoch 20','Epoch 30','Epoch 40')
figure; plot(auxC(1,:,1))
hold on; plot(auxS(1,:,10),'r');plot(auxS(1,:,20),'k');plot(auxS(1,:,30),'g');
plot(auxS(1,:,40),'c')
title('Control Channels')
legend('Epoch 1','Epoch 10','Epoch 20','Epoch 30','Epoch 40')

ch = input('Which channel is best to analyze LFP? ');

WaveControl = squeeze(WaveControl(:,ch,:));
WaveShock = squeeze(WaveShock(:,ch,:));

[P1,F1] = WelchMethod(WaveControl);
[P2,F2] = WelchMethod(WaveShock);


for epoc = 0:9
    
Med1(epoc+1,:) = mean(20*log10(P1(F1(:,1)<=50, (4*epoc + 1) :(4*(epoc+1)) )),2);
SEM1(epoc+1,:) = std(20*log10(P1(F1(:,1)<=50,(4*epoc + 1) :(4*(epoc+1)) )),1)/sqrt(length(P1(F1(:,1)<=50,1)));

Med2(epoc+1,:) = mean(20*log10(P2(F1(:,1)<=50, (4*epoc + 1) :(4*(epoc+1)) )),2);
SEM2(epoc+1,:) = std(20*log10(P2(F1(:,1)<=50,(4*epoc + 1) :(4*(epoc+1)) )),1)/sqrt(length(P1(F1(:,1)<=50,1)));


end

figure; plot(F1(F1(:,1)<=50,1),Med2(1,:))
hold on; plot(F1(F1(:,1)<=50,1),Med2(5,:),'k')
plot(F1(F1(:,1)<=50,1),Med2(10,:),'r')
plot(F1(F1(:,1)<=50,1),Med1(1,:),'g')
plot(F1(F1(:,1)<=50,1),Med1(5,:),'c')
plot(F1(F1(:,1)<=50,1),Med1(10,:),'m')
title(['PSD Spectrum Welch - 140926 - Channel: ' int2str(ch)])
legend('Shock - 1st block','Shock - 5th block','Shock - 10th block', ... 
    'Control - 1st block','Control - 5th block','Control - 10th block')
