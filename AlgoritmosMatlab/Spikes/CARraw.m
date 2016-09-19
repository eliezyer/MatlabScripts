%Algorithm to perform a Common Average Reference, extract more spikes!
PATHIN = 'H:\DadosParaWaveClus';
PATHOUT = 'H:\DadosParaWaveClus\CARData';
cd(PATHIN);
diret = dir;
narq = length(diret);

for ind = 4:narq
    cd(PATHIN);
    name = diret(ind).name;

    fprintf(['loading ' name]);
    load(name);

    Media = mean(Raw1,2);
    % Raw = zeros(Raw1);
    for ch = 1:32
        Raw(:,ch) = Raw1(:,ch) - Media;
    end
    
    cd(PATHOUT);
    fprintf(['saving' name]);
    save(['CARControl_' name(10:end-4)],'Raw','-v7.3')
    
    clear Raw Raw1 Media
    
    
end