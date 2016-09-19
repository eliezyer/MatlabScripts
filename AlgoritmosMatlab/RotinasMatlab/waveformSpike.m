function waveformSpike(Before,After,ChxSc)

% This algoritm will read 2 epoc data and return the cumulative spike waveform from
% specific channels and sortcodes
%
% ChxSc must be a matrix with 2 columns and N rows, N varies with the
% number of channel and sort code that you want to analyze, for example:
% ChXSc = [5 1;5 2;5 3] -> algorithm will analyze sort code 1, 2 and 3 of
% channel 5.
%
% Before is the data before conditioning
%
% After is the data after conditioning

%% Parameters
dt = 0.3; %
CS_duration = 5; %length of sound (in seconds)

time_before = Before(1,1,1).time_windows(1); %time before epoc onset to analyze in histc
time_after = Before(1,1,1).time_windows(2); %time after epoc end to analyze in histc

rng = -(time_before):dt:(CS_duration + time_after); %range of histogram

Hbef = zeros(size(rng)); %Vector to histograms
Haf = zeros(size(rng));

%% plot

for ch = 1:length(ChxSc);


        figure
        for trials = 1:30
            
            %plotting before
            subplot(2,2,1)
            chS = num2str(ChxSc(ch,1));  scS = num2str(ChxSc(ch,2));
            Tit = strcat('Before CS - ch = ',chS,' sc = ',scS); %concatenate strings
            title(Tit)
            hold on
            Ygraph = ylim;
            plot(Before(ChxSc(ch,1),ChxSc(ch,2),trials).spikes,'k')
            
            thisTS = Before(ChxSc(ch,1),ChxSc(ch,2),trials).timeStamps-Before(1,1,1).epoc(2,trials); %Time stamps into relative times with epoc onset
            Hbef = histc(thisTS,rng) + Hbef;
            
            %plotting after
            subplot(2,2,2)
            chS = num2str(ChxSc(ch,1));  scS = num2str(ChxSc(ch,2));
            Tit = strcat('After CS - ch = ',chS,' sc = ',scS); %concatenate strings
            title(Tit)
            hold on
            
            plot(After(ChxSc(ch,1),ChxSc(ch,2),trials).spikes,'r')
            ylim(Ygraph);
           
            thisTS = After(ChxSc(ch,1),ChxSc(ch,2),trials).timeStamps-After(1,1,1).epoc(2,trials);
            Haf = histc(thisTS,rng) + Haf;
            
        end
        
        
        
        %plot of histc
        subplot(2,2,3)
        stairs(rng,Hbef,'k')
        
        subplot(2,2,4)
        stairs(rng,Haf,'r')
        
        Hbef = zeros(size(rng)); %restart vector to another Ch/Sc
        Haf  = zeros(size(rng));

end



    
end