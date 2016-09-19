Fs = 24414;
[b,a] = butter(2,[600*2/Fs 6000*2/Fs]);
Raw1 = double(Raw);
for ch = 1:32
    Raw2(:,ch) = filtfilt(b,a,Raw1(:,ch));
end

avgRaw = median(Raw2,2);

Raw3 = Raw2 - repmat(avgRaw,1,32);