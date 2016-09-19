    dirarq = ['H:\Pesquisa\DadosBrutosExperimento\140924_Exp6trials40'
        'H:\Pesquisa\DadosBrutosExperimento\140925_Exp7trials40'];
blockarq.control = ['~Block-1'
    '~Block-1'];
blockarq.shock = ['~Block-3'
    '~Block-3'];

for narq = 1:length(dirarq)
    
    tankDir = dirarq(narq,:);
    
    for blc = 1:2
        if blc == 1
            tankName = ['Control',tankDir(end-18:end-13)];
            block = blockarq.control(narq,:);
        else
            tankName = ['Shock',tankDir(end-18:end-13)];
            block = blockarq.shock(narq,:);
        end
        tic
        [data] = ExtractCompleteLFP(tankDir,block,tankName);
        toc
        [P1,F1] = WelchMethod(data);
        save(['PSDWelch_',tankName],'P1','F1')
        toc
    end
    
    clear data
end