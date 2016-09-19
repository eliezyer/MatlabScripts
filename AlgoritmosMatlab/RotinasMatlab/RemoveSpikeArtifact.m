
function [new_data] = RemoveSpikeArtifact(data)

%This algorithm will remove any false-positive spike that occur in
%differents channels at same time


new_data = data;
ind = [];
for ch = 1:32
    
    for sc = 1:3
        
        for trial = 1:30; %change to 40 after test..
            
            for in = 1:length(new_data(ch,sc,trial).timeStamps) %number of spikes in a specific trial, sc, ch
                
                
                for channel = 1:32
                    for sortcode = 1:3
                        
                        if ch ~= channel %it's obvious that you'll find a spike in the ocurring in the same time in the same channel
                            
                            if new_data(channel,sortcode,trial).timeStamps == new_data(ch,sc,trial).timeStamps(in)
                                ind = [channel,sortcode,trial,ch,sc,in;ind];
                            
                            end
                        end
                    end
                end
            end
        end
    end
end


for e = 1:length(ind)
     
    new_data(ind(e,1),ind(e,2),ind(e,3)).timeStamps = new_data(ind(e,1),ind(e,2),ind(e,3)).timeStamps(new_data(ind(e,1),ind(e,2),ind(e,3)).timeStamps ~= shock140514_data(ind(e,4),ind(e,5),ind(e,3)).timeStamps(ind(e,6)));
    new_data(ind(e,4),ind(e,5),ind(e,3)).timeStamps = new_data(ind(e,4),ind(e,5),ind(e,3)).timeStamps(new_data(ind(e,4),ind(e,5),ind(e,3)).timeStamps ~= shock140514_data(ind(e,4),ind(e,5),ind(e,3)).timeStamps(ind(e,6))); %there is need of doubling this command to also remove the "original" artifact
    
    new_data(ind(e,1),ind(e,2),ind(e,3)).spikes = new_data(ind(e,1),ind(e,2),ind(e,3)).spikes(new_data(ind(e,1),ind(e,2),ind(e,3)).timeStamps ~= shock140514_data(ind(e,4),ind(e,5),ind(e,3)).timeStamps(ind(e,6))); %is to remove de waveform
    new_data(ind(e,4),ind(e,5),ind(e,3)).spikes = new_data(ind(e,4),ind(e,5),ind(e,3)).spikes(new_data(ind(e,4),ind(e,5),ind(e,3)).timeStamps ~= shock140514_data(ind(e,4),ind(e,5),ind(e,3)).timeStamps(ind(e,6))); 
    
end

end