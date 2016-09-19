    Fs=1017; %Sample frequency
    Fmax=100; %Max visualization frequency
    ch = 14; %channel to analyze
    
    LFP = double(control140514_data(1,1,1).Wave(:,ch,:));
    L=length(LFP(:,1));
    NFFT = 2^nextpow2(L);
    
        for ind = 1:length(control140514_data(1,1,1).epoc)
   
            [P1.trial(:,ind),F1] = pwelch(LFP(:,1,ind),hanning(2048),[1900],NFFT,Fs);
                
        end

        P1.mean = mean(P1.trial,2);
        plot(F1(F1<Fmax),10*log10(P1.mean(1:length(F1(F1<Fmax)))),'k')





% Fs=1017; %Sample frequency
% Fmax=40; %Max visualization frequency
% ch = 2; %channel to analyze
% 
% 
%  
% LFPc = double(control140514_data(1,1,1).Wave(:,ch,:));
% LFPs = double(shock140514_data(1,1,1).Wave(:,ch,:));
% % LFP = zeros(length(shock140514_data(1,1,1).Wave(:,1,:)),2);
% L=length(LFPc(:,1));
% NFFT = 2^nextpow2(L);
% 
% 
% for ind = 1:30
%    
%     [P1.trial(:,ind),F1] = pwelch(LFPc(:,1,ind),hanning(2048),[],NFFT,Fs);
%     [P2.trial(:,ind),F2] = pwelch(LFPs(:,1,ind),hanning(2048),[],NFFT,Fs);
%     
% end
%  
% P1.mean = mean(P1.trial,2);
% P1.std  = std(P1.trial,0,2);
% P2.mean = mean(P2.trial,2);
% P2.std  = std(P2.trial,0,2);
% 
% shadedarea1(:,1) = P1.mean - P1.std;
% shadedarea1(:,2) = P1.mean + P1.std;
% shadedarea2(:,1) = P2.mean - P2.std;
% shadedarea2(:,2) = P2.mean + P2.std;


% %Creating figure
% figure
% patch([F1(F1<Fmax)' fliplr(F1(F1<Fmax)')],[-abs(10*log10(shadedarea1(1:length(F1(F1<Fmax)),2)')) -abs(fliplr(10*log10(shadedarea1(1:length(F1(F1<Fmax)),1)')))],'k','facealpha',0.3,'edgecolor','none')
% hold on
% patch([F2(F2<Fmax)' fliplr(F2(F2<Fmax)')],[-abs(10*log10(shadedarea2(1:length(F2(F2<Fmax)),2)')) -abs(fliplr(10*log10(shadedarea2(1:length(F2(F2<Fmax)),1)')))],'r','facealpha',0.3,'edgecolor','none')
% plot(F2(F2<Fmax),10*log10(P2.mean(1:length(F1(F1<Fmax)))),'r')
% plot(F1(F1<Fmax),10*log10(P1.mean(1:length(F1(F1<Fmax)))),'k')
% legend('Pré Condicionamento','Pós Condicionamento')
% hold off



