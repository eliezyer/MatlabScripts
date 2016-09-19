    pathin = ['G:\Pesquisa\DadosBrutosExperimento\IntervalWave'];
    pathout = ['G:\Pesquisa\DadosBrutosExperimento\SpectrumIntervalWelch'];

    diret = dir(pathin);
    numarqs = size(diret,1);
    
for narq = 3:numarqs
    
    cd(pathin)
    nameFile = diret(narq).name;
    Name = nameFile(1:15);
    load(nameFile)
    [P1,F1] = WelchMethod(data);
    cd(pathout)
    save(['PSDWelch_',Name],'P1','F1')

end