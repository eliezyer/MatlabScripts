pasta = 'C:\Users\Eletrofisiologia\Desktop\ICEliezyer\LFPanalise'; %diretorio para pegar os dados
diret = dir(pasta); %pega toda a informação do diretorio 
numarqs = size(diret,1); %pega o numero de itens dentro do diretorio, e importante colocar somente os dados que vc qr processar neste

for narq = 3:(numarqs + 1)

    
    
cd(pasta)       
nomearq_LFP = diret(narq).name;
load(nomearq_LFP)
data1 = data;

shockarq = ['Shock',nomearq_LFP(end-9:end)];
load(shockarq)
data2 = data;
clear data

name = nomearq_LFP(end-9:end-4);

LFPanalyzer(data1,data2,name)


end
