Wave = control140514_data(1,1,1).Wave;
B = fir1(600,[150/1017 250/1017]);

for trial = 1:30
    WaveFil1(:,trial) = filtfilt(B,1,Wave(:,2,trial));
    for e = 0:ceil(length(control140514_data(1,1,1).Wave)/5)-21;
     
      RMSmatrix(e+1,trial)  =  sqrt(sum(WaveFil1((5*e)+1:(5*e)+21,trial).^2)/20);
  
    end

    y(trial) = std(RMSmatrix(:,trial));

end

tr = 1
plot(RMSmatrix(:,tr),'r')
hold on
plot(1:length(WaveFil1(:,tr)),y(tr),'k')
plot(1:length(WaveFil1(:,tr)),3*y(tr),'k')
hold off