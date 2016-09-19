pathin = ['E:\AnaliseLFP\Wave7s\DadosBrutos'];
pathout = ['E:\AnaliseLFP\Wave7s\SpecWelch'];

diret = dir(pathin);
numarqs = size(diret,1);
count = 0;
for narqs = 3:numarqs
    cd(pathin)
    nome_arq = diret(narqs).name;
    load(nome_arq)
    tankName = data.tankName
    if strcmp(tankName(end-1:end),'17')
        count = count+1;
        tankName = [tankName(1:end-1) '6_exp' num2str(count)];
    end
    Waves = squeeze(data.Wave(:,15,:));
    [P1,F1] = WelchMethod(Waves);
    cd(pathout)
    save(['PSDWelch_',tankName],'P1','F1')
end