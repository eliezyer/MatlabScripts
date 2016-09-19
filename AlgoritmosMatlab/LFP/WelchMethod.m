function [P1,F1] = WelchMethod(data)%% PSD with welch method

%Parameters
    Fs=1017.26; %Sample frequency

 
%  LFP1 = data.Wave;
    LFPaux = data;
    
    % LFP2 = data2.Wave(:,ch);
    L=length(LFPaux(:,1));
    NFFT = 2^nextpow2(L);
    
    for index = 1:40
    %PSD spectrogram
    LFP1 = (LFPaux(:,index) - mean(LFPaux(:,index)))/std(LFPaux(:,index)); %normalize data
    [P1(:,index),F1(:,index)] = pwelch(LFP1(:,1),hanning(1000),[600],NFFT,Fs);
    
    end

end