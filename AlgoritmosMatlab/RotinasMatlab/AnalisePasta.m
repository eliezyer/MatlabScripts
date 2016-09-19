PATHIN = 'H:\Pesquisa\DadosBrutosExperimento'; %pasta para pegar os dados
% PATHOUT = 'H:\AnaliseLFP\Wave7s'; %Inserir pasta para salvar os novos dados processados
cd(PATHIN)
diret = dir(PATHIN); %cria uma struture no matlab com as informações do diretório atual
numarqs = size(diret,1); %retira a quantidade de arquivos que existem na pasta que vc informou 
%é importante que a pasta de entrada tenha apenas os arquivos que vc irá processar!

for narq = 3:numarqs, %este for começa em 3 pq os índices 1 e 2 não são 
    %arquivos (pelo menos no windows), se vc tentar diret(1).name ele
    %devolve . como resposta, se usar diret(2).name ele devolve .. 
    %A partir do diret(3).name ele começa a retornar os nomes dos arquivos
    %Acho que para o MAC tem que testar o que ocorre e se for diferente
    %atualizar o for

    
    
cd(PATHIN) %current diretory setado para a pasta onde vai ler os arquivos       
nomearq_LFP = diret(narq).name; %aqui o for entra com o número do arquivo e retira o nome dele
if ( strcmp(nomearq_LFP,'140925_Exp7trials40') || strcmp(nomearq_LFP,'140924_Exp6trials40') )
block = '~Block-3';
else
block = '~Block-2';
end
ExtractWave([PATHIN filesep nomearq_LFP],block,['Shock' nomearq_LFP(1:6)],[],[1 1]);
% load(nomearq_LFP) %carrega o arquivo
% data1 = data; %vc pode até desconsiderar isso, o nome do arquivo só era mudado para a análise






% % % % % O PROCESSAMENTO DEVE SER INSERIDO AQUI







% cd(PATHOUT) %muda o diretório para salvar os novos dados na pasta informada anteriormente
% save('nome_do_arquivo','nome_da_variável_que_sera_salva') %esse comando pode ser bem lento! escrever em disco é uma tarefa pesada
% clear data %eu colocava esse clear nos meus dados para limpar a memória e não dar OUT OF MEMORY no MATLAB
end