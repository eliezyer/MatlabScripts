pasta = 'H:\Pesquisa\DadosBrutosExperimento\SpectrumWelch'; %pasta para pegar os dados
diret = dir(pasta);
cd(pasta);
numarqs = size(diret,1);
int1 = 1; %count control
int2 = 1; %count shock
int3 = 1;
int4 = 1;
int5 = 1;
int6 = 1;
Fmax = 100;

for narq = 3:(numarqs),
    
    namearq = diret(narq).name;
    load(namearq)
    
    if namearq(end-16:end-10) == 'Control'
       Welch1PSD(int1,:) = P1';
       int1 = int1+1;
    elseif namearq(end-14:end-10) == 'Shock'
       Welch2PSD(int2,:) = P1';
       int2 = int2+1;
%     if namearq(18) == '1'
%        Welch1PSD(int1,:) = P1';
%        int1 = int1+1;
%     elseif namearq(18) == '2'
%        Welch2PSD(int2,:) = P1';
%        int2 = int2+1;
%      elseif namearq(18) == '3'
%         Welch3PSD(int3,:) = P1';
%         int3 = int3+1;
%     elseif namearq(18) == '4'
%        Welch4PSD(int4,:) = P1';
%        int4 = int4+1;
%     elseif namearq(18) == '5'
%        Welch5PSD(int5,:) = P1';
%        int5 = int5+1;
%     elseif namearq(18) == '6'
%        Welch6PSD(int6,:) = P1';
%        int6 = int6+1
    end
    
end


MWelchPSD(:,1) = mean(Welch1PSD,1);
MWelchPSD(:,2) = mean(Welch2PSD,1);
% MWelchPSD(:,3) = mean(Welch3PSD,1);
% MWelchPSD(:,4) = mean(Welch4PSD,1);
% MWelchPSD(:,5) = mean(Welch5PSD,1);
% MWelchPSD(:,6) = mean(Welch6PSD,1);

% SEMWelchPSD(:,1) = std(Welch1PSD,1)/sqrt(2);
% SEMWelchPSD(:,2) = std(Welch2PSD,1)/sqrt(2);

SEMWelchPSD(:,1) = std(Welch1PSD,1)/sqrt(5);
SEMWelchPSD(:,2) = std(Welch2PSD,1)/sqrt(5);
% SEMWelchPSD(:,3) = std(Welch3PSD,1)/sqrt(5);
% SEMWelchPSD(:,4) = std(Welch4PSD,1)/sqrt(5);
% SEMWelchPSD(:,5) = std(Welch5PSD,1)/sqrt(5);
% SEMWelchPSD(:,6) = std(Welch6PSD,1)/sqrt(5);

figure
cor = ['k','r','y','c','b','g'];
hold on

for i = 1:2

ShadedControlplus = 10*log10((MWelchPSD(1:length(F1(F1>0.3 & F1<Fmax)),i)'+(SEMWelchPSD(1:length(F1(F1>0.3 & F1<Fmax)),i)')));
ShadedControlminus = 10*log10((MWelchPSD(1:length(F1(F1>0.3 & F1<Fmax)),i)'-(SEMWelchPSD(1:length(F1(F1>0.3 & F1<Fmax)),i)')));
semilogx(F1(F1>0.3 & F1<Fmax),10*log10(MWelchPSD(1:length(F1(F1>0.3 & F1<Fmax)),i)),cor(i),'LineWidth',2)
 fill([F1(F1>0.3 & F1<Fmax);flipud(F1(F1>0.3 & F1<Fmax))], [ShadedControlminus'; flipud(ShadedControlplus')],cor(i))
 alpha(0.25)
end


ylabel('Log PSD (dB)')
xlabel('Frequency')


