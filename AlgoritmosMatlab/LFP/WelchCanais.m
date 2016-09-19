
Wavec = dataControl.Wave;
WaveS = dataShock.Wave;


    for ch = 1:32
   
        Bef = squeeze(Wavec(:,ch,:));
        Aft = squeeze(WaveS(:,ch,:));
        [P1(:,:,ch),F1(:,:,ch)] = WelchMethod(Bef);
        [P2(:,:,ch),F2(:,:,ch)] = WelchMethod(Aft);
               
        
    end
    
    
Pc = squeeze(mean(P1,2));
Ps = squeeze(mean(P2,2));
Fc = F1(:,1,1);
Fs = F2(:,1,1);

indF = 0;
for freq = 2:2:120
    indF = indF + 1;
    PotC = sum(Pc( Fc > freq-2 & Fc < freq, :));
    PotS = sum(Ps( Fs > freq-2 & Fs < freq, :));
    [auxhC,auxiC] = hist( PotC ,20);
    [auxhS,auxiS] = hist( PotS ,20);
    
    idxC = find(auxiC<auxiS(:,1));
    idxS = find(auxiS<auxiC(:,1));
    
    if isempty(idxS)
        maxV = max(auxiS);
        minV = min(auxiC);
        step = (maxV - minV)/40;
        xValues = minV:step:maxV; %vetor para fazer novo histograma
        
        [hC(:,indF),iC(:,indF)] = hist(PotC,xValues);
        [hS(:,indF),iS(:,indF)] = hist(PotS,xValues);
        
        
    elseif isempty(idxC)
        maxV = max(auxiC);
        minV = min(auxiS);
        step = (maxV - minV)/40;
        xValues = minV:step:maxV; %vetor para fazer novo histograma
      
        [hC(:,indF),iC(:,indF)] = hist(PotC,xValues);
        [hS(:,indF),iS(:,indF)] = hist(PotS,xValues);
    end
    
    hC(:,indF) = hC(:,indF)/sum(hC(:,indF));
    hS(:,indF) = hS(:,indF)/sum(hS(:,indF));
    
    
    Measure(:,indF) = max(abs(cumsum(hC(:,indF)) - cumsum(hS(:,indF)) ));
end


figure(2);hold on;plot(((1:length(Measure))/length(Measure))*120,Measure,'k','LineWidth',2);


