function [PHASE,Waves,unwrappedPhase] = extractHTPhase(data)
%function to extract instant phase of hilbert transform.

[b] = fir1(900,[6/508.5 13/508.5]);
% freqz(b,1,2048,1017)
Fs = 1017;
% 
% Waves = filtfilt(b,1,data.Wave(:,:,ind));
% HT = hilbert(Waves);
% 
% U = imag(HT);
% V = real(HT);
% PHASE = atan(U./V);
% Waves = data.Wave;
PHASE = zeros(size(data.Wave));

for ind = 1:40
    Waves(:,:,ind) = filtfilt(b,1,data.Wave(:,:,ind));    
    HT = hilbert(Waves(:,:,ind));
    U = imag(HT);
    V = real(HT);
    PHASE(:,:,ind) = atan2(U,V);

    %%montar uma busca em fase, quando passar de negativo para positivo
    %%somar 
   
    
end

unwrappedPhase = zeros(size(PHASE));

for ch = 1:32
    for epoch = 1:40
        phaseConst = 0;
        index = 1;
        for index = 1:length(PHASE)-1
            
            unwrappedPhase(index,ch,epoch) = PHASE(index,ch,epoch) + phaseConst;
            if PHASE(index, ch, epoch) >= 1 && PHASE(index+1, ch, epoch) <=-1
                
                phaseConst = phaseConst + pi;
                                       
            end
            index = index + 1;
        end
        unwrappedPhase(end,ch,epoch) = PHASE(end,ch,epoch) + phaseConst; % I did this because the last point stay out of loop
    end
end



%% para plotar o gráfico
ch = 16;

for epoch = 1:40

    if epoch <= 4
        fromZero2piundTwo = find(PHASE(:,ch,epoch)>0 & PHASE(:,ch,epoch) <= pi/2);
        frompiundTwo2Pi = find(PHASE(:,ch,epoch)>pi/2 & PHASE(:,ch,epoch)<= pi);
        fromPi2ThreePiundTwo = find(PHASE(:,ch,epoch)> -pi & PHASE(:,ch,epoch) <= -pi/2);
        fromThreePiundTwo2TwoPi = find(PHASE(:,ch,epoch)>-pi/2 & PHASE(:,ch,epoch) <= 0);
        subplot(4,1,epoch)
        plot(frompiundTwo2Pi,Waves(frompiundTwo2Pi,ch,epoch),'sr',fromThreePiundTwo2TwoPi,Waves(fromThreePiundTwo2TwoPi,ch,epoch),'sg',fromPi2ThreePiundTwo,Waves(fromPi2ThreePiundTwo,ch,epoch),'sy',fromZero2piundTwo,Waves(fromZero2piundTwo,ch,epoch),'sb')
    end
end

end