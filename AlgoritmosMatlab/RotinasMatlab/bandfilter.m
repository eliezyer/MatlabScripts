function [data]=bandfilter(data,flag)
%this function will filter the entire signal in to five different bands,
%delta (0.5 - 4), theta(4 - 12.5), beta(12.5 - 30), slow gamma(30 - 59),
%fast gamma(61 - 120), and will save in the structure data

%flag is a binary variable to comunicate algorithm that you want to print
%bode plots from these filters. If flag = 1 bode plot is printed, if flag ~=1 it
%doesn't print anything


dataDelta = zeros(size(data(1,1,1).Wave));
dataTheta = zeros(size(data(1,1,1).Wave));
dataBeta  = zeros(size(data(1,1,1).Wave));
dataSGamma= zeros(size(data(1,1,1).Wave));
dataFGamma= zeros(size(data(1,1,1).Wave));


Bdelta = fir1(1200,[0.3/508.5 4.4/508.5]); %filter for delta waves
Btheta = fir1(900,[3.5/508.5 12.5/508.5]); %filter for theta waves
Bbeta  = fir1(900,[12.3/508.5 30.3/508.5]); %filter for beta waves
Bsgamma= fir1(900,[29.6/508.5 59.9/508.5]); %filter for slow gamma waves
Bfgamma= fir1(900,[60/508.5 123/508.5]); %filter for high gamma waves

%% Bode PLot
if flag == 1
figure
freqz(Bdelta,1,2048,1017)
figure
freqz(Btheta,1,2048,1017)
figure
freqz(Bbeta,1,2048,1017)
figure
freqz(Bsgamma,1,2048,1017)
figure
freqz(Bfgamma,1,2048,1017) %b components, a components, N (frequency resolution?), Fs for x axis
end

%% Filtfilt data
for ch = 1:32
    
    for trials = 1:30
    
    dataDelta(:,ch,trials) = filtfilt(Bdelta,1,data(1,1,1).Wave(:,ch,trials));
    dataTheta(:,ch,trials) = filtfilt(Btheta,1,data(1,1,1).Wave(:,ch,trials));
    dataBeta(:,ch,trials)  = filtfilt(Bbeta,1,data(1,1,1).Wave(:,ch,trials));
    dataSGamma(:,ch,trials) = filtfilt(Bsgamma,1,data(1,1,1).Wave(:,ch,trials));
    dataFGamma(:,ch,trials) = filtfilt(Bfgamma,1,data(1,1,1).Wave(:,ch,trials));
    
    end

end

%% Data receives filtered waves
data(1,1,1).wavesDelta = dataDelta;
data(1,1,1).wavesTheta = dataTheta;
data(1,1,1).wavesBeta  = dataBeta;
data(1,1,1).wavesSGamma= dataSGamma;
data(1,1,1).wavesFGamma= dataFGamma;

end

