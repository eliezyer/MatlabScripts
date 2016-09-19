% function [h,p] = statisticBands(Welch1PSD,Welch2PSD,F1)

% for ind = 1:size(Welch1PSD,1)
% area1Delta(1,ind) = sum(10*log10(Welch1PSD(ind,F1>0.3 & F1 <4)));
% area1Theta(1,ind) = sum(10*log10(Welch1PSD(ind,F1>4 & F1 <12)));
% area1Beta(1,ind) = sum(10*log10(Welch1PSD(ind,F1>12 & F1 <30)));
% area1SGamma(1,ind) = sum(10*log10(Welch1PSD(ind,F1>30 & F1 <58)));
% area1FGamma(1,ind) = sum(10*log10(Welch1PSD(ind,F1>62 & F1 <120)));
% 
% area2Delta(1,ind) = sum(10*log10(Welch2PSD(ind,F1>0.3 & F1 <4)));
% area2Theta(1,ind) = sum(10*log10(Welch2PSD(ind,F1>4 & F1 <12)));
% area2Beta(1,ind) = sum(10*log10(Welch2PSD(ind,F1>12 & F1 <30)));
% area2SGamma(1,ind) = sum(10*log10(Welch2PSD(ind,F1>30 & F1 <58)));
% area2FGamma(1,ind) = sum(10*log10(Welch2PSD(ind,F1>62 & F1 <120)));
% 
% end
% 
%  [h(1),p(1)] = ttest(area2Delta,area1Delta);
%  [h(2),p(2)] = ttest(area2Theta,area1Theta);
%  [h(3),p(3)] = ttest(area2Beta,area1Beta);
%  [h(4),p(4)] = ttest(area2SGamma,area1SGamma);
%  [h(5),p(5)] = ttest(area2FGamma,area1FGamma);


for ind = 1:length(Welch1PSD(F1<100))
    
    [h(ind),p(ind)] = ttest(10*log10(Welch1PSD(:,ind)),10*log10(Welch2PSD(:,ind)),'left');

end



% 
% end