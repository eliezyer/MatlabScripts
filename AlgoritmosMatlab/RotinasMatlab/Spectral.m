%algoritmo para plotar espectrograma

NFFT = 1024; %Number of frequency points to calculate the DFT
Fs = 1000; %Sampling frequency
WindowLength = 300; %Data size for analysis of DFT
WindowOverlap = 250; %Overlap of windows

LFPt = double(Wave(:,28,:));%For spectrogram, X input needs to be a double variable
LFP = zeros(15259,1);

for ind = 1:30
   
       LFP(:,1) = LFPt(:,1,ind) + LFP;
    
end

LFP = LFP/30;
LFP = LFP - mean(LFP);

x = linspace(-5, 10, 300);
y = 1:100;
s = spectrogram(LFP,WindowLength,WindowOverlap,NFFT,Fs,'yaxis');

%plotting
figure, imagesc(x(1,:),1:100,10*log10(abs(s(1:100,:))));
axis xy
hold on
plot( [0 0], [0 50],'k','LineWidth',2)
plot( [5 5], [0 50],'k','LineWidth',2)
hold off
ylabel('Frequência (Hz)')
xlabel('Tempo (s)')


