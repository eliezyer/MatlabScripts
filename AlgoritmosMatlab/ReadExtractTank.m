pathin = ['H:\Pesquisa\DadosBrutosExperimento'];
pathout = ['H:\DadosParaWaveClus'];

diret = dir(pathin);
numarqs = size(diret,1);

for narq = 3:numarqs-1
    cd(pathin)
    SubjectName = diret(narq).name;
    if ( strcmp(SubjectName,'140925_Exp7trials40') || strcmp(SubjectName,'140924_Exp6trials40') )
        block = '~Block-3';
    else
        block = '~Block-2';
    end
    %% Creating tank and parameters    

    TTX = actxcontrol('TTank.X');
    TTX.ConnectServer('Local','Me');
    TTX.OpenTank(SubjectName, 'R');
    TTX.SelectBlock(block);
    Raw1 = [];
for e = 1:25 %%MUDAR PARA 25, FAZER DUAS VEZES DE 25 A EXTRAÇAO!
        
    TTX.SetGlobalV('T1',((e-1)*100));
    TTX.SetGlobalV('T2',e*100);
    
    %% Reading|Extract 
    
    for ch = 1:32
        TTX.SetGlobalV('Channel', ch);
        
        Raw(:,ch) = TTX.ReadWavesV('Raw1');
        
    end
Raw1 = [Raw1; Raw];
end
TTX.CloseTank


TTX.ReleaseServer

cd(pathout)
save(['PosShock_' diret(narq).name],'Raw1','-v7.3')
clear Raw1 Raw


end

