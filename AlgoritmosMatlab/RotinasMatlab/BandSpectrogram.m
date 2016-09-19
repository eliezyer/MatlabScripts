function BandSpectrogram(data)
%Parameters
Delta = data(1,1,1).wavesDelta;
Theta = data(1,1,1).wavesTheta;
Beta = data(1,1,1).wavesBeta;
SlowGamma = data(1,1,1).wavesSGamma;
FastGamma = data(1,1,1).wavesFGamma;


NFFT = 2^nextpow2(length(data(1,1,1).Wave)); %Number of frequency points to calculate the DFT
Fs = 1017.26; %Sampling frequency
WindowLength = hanning(1000); %Data size for analysis of DFT
WindowOverlap = [800]; %Overlap of windows
Nplot = ceil(100/(Fs/NFFT)) ;%Row number to plot until frequency 100 Hz (Deltafreq = Fs/NFFT)
specd = zeros(floor(NFFT/2)+1,174,length(data(1,1,1).epoc));
spect = zeros(floor(NFFT/2)+1,174,length(data(1,1,1).epoc));
specb = zeros(floor(NFFT/2)+1,174,length(data(1,1,1).epoc));
specsG= zeros(floor(NFFT/2)+1,174,length(data(1,1,1).epoc));
specfG= zeros(floor(NFFT/2)+1,174,length(data(1,1,1).epoc));

ch = 4; %channel to analyze
LFPd = double(Delta(:,ch,:));%For spectrogram, X input needs to be a double variable
LFPt = double(Theta(:,ch,:));
LFPb = double(Beta(:,ch,:));
LFPsG = double(SlowGamma(:,ch,:));
LFPfG = double(FastGamma(:,ch,:));


%spectrogram
for ind = 1:length(data(1,1,1).epoc)
    %delta
    [s,f,t,specd(:,:,ind)] = spectrogram(LFPd(:,1,ind),WindowLength,WindowOverlap,NFFT,Fs,'yaxis'); %extracting PSD
    %theta
    [s,f,t,spect(:,:,ind)] = spectrogram(LFPt(:,1,ind),WindowLength,WindowOverlap,NFFT,Fs,'yaxis');
    %beta
    [s,f,t,specb(:,:,ind)] = spectrogram(LFPb(:,1,ind),WindowLength,WindowOverlap,NFFT,Fs,'yaxis');
    %slow gamma
    [s,f,t,specsG(:,:,ind)] = spectrogram(LFPsG(:,1,ind),WindowLength,WindowOverlap,NFFT,Fs,'yaxis');
    %fast gamma
    [s,f,t,specfG(:,:,ind)] = spectrogram(LFPfG(:,1,ind),WindowLength,WindowOverlap,NFFT,Fs,'yaxis');
end

specdm = mean(specd,3);
spectm = mean(spect,3);
specbm = mean(specb,3);
specsGm = mean(specsG,3);
specfGm = mean(specfG,3);

x = linspace(-data.time_windows(1), data.time_windows(2) + 5, size(specd,2));

%plotting
figure
subplot(5,1,1)
imagesc(x(1,:),f(f>62 & f<120),10*log10(abs(specfGm(f>62 & f<120,:))))
axis xy, hold on
plot([0 0], ylim,'--k', [5 5], ylim,'--k')
hold off
ylabel('fast-\gamma (61-120)')
xlabel('Tempo (s)')

subplot(5,1,2)
imagesc(x(1,:),f(f>31 & f<58),10*log10(abs(specsGm(f>31 & f<58,:))))
axis xy, hold on
plot([0 0], ylim,'--k', [5 5], ylim,'--k')
hold off
ylabel('slow-\gamma (30 - 59 Hz)')
xlabel('Tempo (s)')

subplot(5,1,3)
imagesc(x(1,:),f(f>13 & f<29),10*log10(abs(specbm(f>13 & f<29,:))))
axis xy, hold on
plot([0 0], ylim,'--k', [5 5], ylim,'--k')
hold off
ylabel('\beta (12 - 30 Hz)')
xlabel('Tempo (s)')

subplot(5,1,4)
imagesc(x(1,:),f(f>4.5 & f<11.5),10*log10(abs(spectm(f>4.5 & f<11.5,:))))
axis xy, hold on
plot([0 0], ylim,'--k', [5 5], ylim,'--k')
hold off
ylabel('\theta (4 - 12 Hz)')
xlabel('Tempo (s)')

subplot(5,1,5)
imagesc(x(1,:),f(f>0.3 & f<4),10*log10(abs(specdm(f>0.3 & f<4,:))))
axis xy, hold on
plot([0 0], ylim,'--k', [5 5], ylim,'--k')
hold off
ylabel('\delta (0.3 - 4 Hz)')
xlabel('Tempo (s)')

save('SpectrogramBands.mat','specd','spect','specb','specsG','specfG')

end