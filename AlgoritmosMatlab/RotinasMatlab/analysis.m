function [spec] = analysis(data)

% Parameters for analysis
dt = 0.3;                   % delta time for bin width of histograms
CS_duration = 5;            % how long the CS is presented

time_before = data(1,1,1).time_windows(1);
time_after  = data(1,1,1).time_windows(2);

rng = -(time_before):dt:CS_duration+time_after;     % range for edges in histograms (histc)
H = zeros(size(rng));           % vector to hold the histogram counts

%% PSD with welch method

%Parameters
Fs=1017; %Sample frequency
Fmax=40; %Max visualization frequency
ch = 1; %channel to analyze
LFP = double(data(1,1,1).Wave(:,ch,:));
L=length(LFP(:,1));
NFFT = 2^nextpow2(L);

%PSD spectrogram
for ind = 1:length(data(1,1,1).epoc)
    
    [P1.trial(:,ind),F1] = pwelch(LFP(:,1,ind),hanning(2048),[],NFFT,Fs);
    
end

P1.mean = mean(P1.trial,2);

%plotting
figure;
plot(F1(F1<Fmax),10*log10(P1.mean(1:length(F1(F1<Fmax)))),'k')

%% Rasterplot with plot command


sc = 1;
ch = 1;
for ind = 1:6
    figure
    index = 1;
    
    while ( ch <= length(data(:,1,1)))
        
        
        while( sc <= length(data(1,:,1)))
            
            subplot(4,4,index)
            chS = num2str(ch);  scS = num2str(sc);% string to identify plot
            Tit = strcat('ch = ',chS,' sc = ',scS); %concatenate strings
            title(Tit)
            hold on
            
            for trial=1:length(data(1,1,:)) %take numbers of epoc for loop
                
                thisTS = data(ch,sc,trial).timeStamps-data(1,1,1).epoc(2,trial);
                plot(thisTS,trial,'ks','markersize',2,'markerfacecolor','k');
                
                H = histc(thisTS,rng) + H;     % to be used wiht stairs
                %H = histc(thisTS,rng-dt/2) + H; % to be used with plot
                
            end
            
            stairs(rng,length(data(1,1,1).epoc)*(H/max(H)),'r');     %plot histogram ponderated in number of epocs
            xlim([-5 10])
            H = zeros(size(rng));  % vector to hold the histogram counts
            index = index + 1;
            sc = sc + 1;
            if index > 16
                break
            end
            
        end
        
        if index > 16
            break
        end
        ch = ch + 1;
        sc = 1;
    end
    
end



%stairs(rng,H);

%plot(linspace(-5,10,length(H)),(H/(70*30)))


end

