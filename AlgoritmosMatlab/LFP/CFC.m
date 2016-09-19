
h = waitbar(0,'Calc Modulation Index');
Waves = data.Wave;
ch = 15;
for trials = 1:40
        signal = squeeze(Waves(:,ch,trials));
        signal = signal - mean(signal);
        indF = 0;
 waitbar(trials/40),h,['Trial: ' int2str(trials) ' of 40']
 for Phfreq = 0.5:0.25:12 %em hz
     [bf] = fir1(2000, [Phfreq/500 (Phfreq+2.5)/500]);
     f = filtfilt(bf,1,signal);
     indF = indF + 1;
             % hilbert para fase
        auxPhase = hilbert(f);
        realPha  = real(auxPhase);
        imagPha  = imag(auxPhase);
        Phase = atan2(imagPha,realPha);
        Phase = Phase + pi;
        
        indA = 0;
        
    for Afreq = 20:0.25:50

        [b] = fir1(2000, [Afreq/500 (Afreq+35)/500]);
        Ap = filtfilt(b,1,signal);
        indA = indA + 1;

        %hilbert para envelope amplitude
        auxAmp = hilbert(Ap);
        realAmp = real(auxAmp);
        imagAmp = imag(auxAmp);
        Amp = sqrt(realAmp.^2 + imagAmp.^2);
        
        %criar bin de fases, no artigo a imagem parece ser de 18�, dando 20 bins no
        %total
        
        bin = 18*pi/180;
        oldBin = 0;
        newBin = bin;
        AmpMedia = 0;
        
        for bins = 1:round(360*pi/(180*bin));
            index = find(Phase > oldBin & Phase < newBin);
            AmpMedia(bins) = mean(Amp(index));
            oldBin = newBin;
            newBin = oldBin + bin;
        end
        
        Amplitude(trials,:) = AmpMedia./sum(AmpMedia);

        Uniforme = ones(1,20)./20;
          %divergencia de kullback leibler
        Dkl =  sum(Amplitude(trials,:) .* log( Amplitude(trials,:) ./ Uniforme )) ;
        %MI(trials) = Dkl/log(20);       
        MI2(indF,indA,trials) = Dkl/log(20);
    end
    
end

end

