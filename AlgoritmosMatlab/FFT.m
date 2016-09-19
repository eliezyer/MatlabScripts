close all
Fs=1017; %Sample frequency
Fv=100; %Max visualization frequency
LFPc = double(control140514_data(1,1,1).Wave(:,14,:));
LFPs = double(shock140514_data(1,1,1).Wave(:,14,:));
LFP = zeros(15259,2);
L=length(LFP(:,1));
NFFT = 2^nextpow2(L);
f=Fs/2*linspace(0,1,NFFT/2+1);

for ind = 1:30
   
%        LFP(:,1) = LFPc(:,1,ind) + LFP(:,1);
%        LFP(:,2) = LFPs(:,1,ind) + LFP(:,2);
[V(ind).P1,V(ind).F1] = pwelch(LFPc(:,1,ind),400,350,NFFT,Fs);
[V(ind).P2,V(ind).F2] = pwelch(LFPs(:,2,ind),400,350,NFFT,Fs);    


end
 

%linspace gera um vetor de NFFT/2+1 pontos entre 0 e 1
% X = LFP(:,1);
% X = X - mean(X);


spectrum(:,1)=fft(LFP(:,1),NFFT)/L;
spectrum(:,2)=fft(LFP(:,2),NFFT)/L;
% plot(f,2*abs(spectrum(1:NFFT/2+1)));

%creating gauss to convolution with FFT
sigma = 1;
dt = 0.05;
X = -10:dt:10;
GAUSS = 1/(sqrt(2*pi)*sigma)*exp(-0.5*X.^2/(sigma^2));

[P1,F1] = pwelch(LFP(:,1),400,350,NFFT,Fs);
[P2,F2] = pwelch(LFP(:,2),400,350,NFFT,Fs);

figure
plot(F1(F1<Fv),10*log10(P1(1:length(F1(F1<Fv)))),'k')
hold on
plot(F2(F2<Fv),10*log10(P2(1:length(F1(F1<Fv)))),'r')
legend('Pré Condicionamento','Pós Condicionamento')
hold off

OptSpec(:,1) = conv(GAUSS,2*abs(spectrum(1:NFFT/2+1,1)));
OptSpec(:,2) = conv(GAUSS,2*abs(spectrum(1:NFFT/2+1,2)));

figure
plot(f(f<Fv),OptSpec(1:length(f(f<Fv)),1),'k')
hold on
plot(f(f<Fv),OptSpec(1:length(f(f<Fv)),2),'r')
legend('Pré Condicionamento','Pós Condicionamento')
hold off

figure
plot(f(f<Fv),2*abs(spectrum(1:length(f(f<Fv)),1)),'k');
hold on
plot(f(f<Fv),2*abs(spectrum(1:length(f(f<Fv)),2)),'r');
legend('Pré Condicionamento','Pós Condicionamento')
hold off

