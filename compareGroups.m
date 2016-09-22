

rng = 0:0.1:3;

for sess = 1:4;
    
    
    DD = [];
    for k = 1:6
        D = gatherDrrd(k,sess,false);
        DD = [DD; D(:,1)];
    end
    DD1 = DD;
    
    DD = [];
    for k = 7:15
        D = gatherDrrd(k,sess,false);
        DD = [DD; D(:,1)];
    end
    DD2 = DD;
    
    
    subplot(2,2,sess);
    stairs(rng,histc(DD1,rng)/length(DD1),'k');
    hold on;
    stairs(rng,histc(DD2,rng)/length(DD2),'r');
    title(['Sessao' num2str(sess)]);
    
end
