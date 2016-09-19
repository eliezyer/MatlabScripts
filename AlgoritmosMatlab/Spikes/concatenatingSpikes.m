subject = '20160119';
load(subject);

for ch = 1:32
    clear PA spikes index
    for epc = 1:240
        if isnan(data(ch,1,epc).spikes)
            PA(epc).spikes = [];
            PA(epc).index = [];
        elseif isnan(data(ch,2,epc).spikes)
            PA(epc).spikes = (data(ch,1,epc).spikes);
            PA(epc).index = (data(ch,1,epc).timeStamps);
        elseif isnan(data(ch,3,epc).spikes)
            PA(epc).spikes = cat(2,data(ch,1,epc).spikes,data(ch,2,epc).spikes);
            PA(epc).index = cat(2,data(ch,1,epc).timeStamps,data(ch,2,epc).timeStamps);
        elseif isnan(data(ch,4,epc).spikes)
            PA(epc).spikes = cat(2,data(ch,1,epc).spikes,data(ch,2,epc).spikes,data(ch,3,epc).spikes);
            PA(epc).index = cat(2,data(ch,1,epc).timeStamps,data(ch,2,epc).timeStamps,data(ch,3,epc).timeStamps);
        else
            PA(epc).spikes = cat(2,data(ch,1,epc).spikes,data(ch,2,epc).spikes,data(ch,3,epc).spikes,data(ch,4,epc).spikes);
            PA(epc).index = cat(2,data(ch,1,epc).timeStamps,data(ch,2,epc).timeStamps,data(ch,3,epc).timeStamps,data(ch,4,epc).timeStamps);
        end
    end
    
    spikes = [];
    index = [];
    for epc = 1:240
        
        spikes = cat(2,spikes,PA(epc).spikes);
        index = cat(2,index,PA(epc).index);
    end
    
    spikes = spikes';
    index = index';
    save([subject 'CH' num2str(ch) 'spikes'],'spikes','index','-v7.3')
end