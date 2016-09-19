%This algorithm will run only if TTank is open.
%It will separate spikes by channel and do the PCA for each channel
%% Separating data by channel

spikebc = cell(1,32);
for e = 1:32
    
       
    
   for j = 1:N
   if channels (1,j) == e
   
       spikebc{1,e} = [spikebc{1,e} spikes(:,j)];  %spikebc is spike by channel cell.
       
      
         
   end
   end
   
end

[coeff,score,latent] = princomp(spikebc{1,3});