cd C:\Users\guilherme.souza\Documents\MATLAB %Alterar para computador

%Calcula o tempo médio das 100 ultimas respostas realizadas pelos ratos em
%cada sessão

clear all

% Experimento 1
ratos  = [79:90]; %Alterar numeração dos ratos.
grupos = [ 1 1 1 1 2 2 2 2 3 3 3 3]; %Alterar número dos grupos de acordo com a quantidade de ratos em cada grupo. 

Sessao =[1 2 3];  %Selecionar o número de sessões que se deseja analisar.


x=0;

% E= NaN(length (ratos),4);

for k = 1:length(Sessao)
    x=x+1;
    j=1;
    l=1;
    m=1;
    
    
    for i=1:length(ratos)
        
        D= drrd('AH0',ratos(i),Sessao(k),1,0);close all
        
        if isempty(D)                                      %se a matriz de 'D' for vazia (ou seja, o rato nao realizou tentativas na sessão),considere a matriz como NaN.
            ultimas_100=NaN;
            Media_grupo=nanmean(ultimas_100);
        elseif length(D(:,1))<50                           %se D apresentar menos que 50 trials, considerar D como NaN.
            ultimas_100=NaN;
            Media_grupo=nanmean(ultimas_100);
        elseif length(D(:,1))>=50 && length(D(:,1))<100    %Se D for maior que 50 e menor que 100, considere todas as linhas da primeira coluna.
            ultimas_100= D(:,1);
            Media_grupo=nanmean(ultimas_100);
        else  ultimas_100= D(end-100:end,1);              %ultimas 100 trials apresentadas pelo rato em cada sessão.
            Media_grupo=nanmean (ultimas_100);            %Realiza a média das ultimas 100 trials, desconsiderando as matrizes contendo apenas NaN.
        end
        
        
        if grupos(i)==1
            grupo_ASLP(x,j)= Media_grupo;               %Realiza a média das ultimas 100 respostas para o grupo ASLP, desconsiderando os valores NaN.
            j=j+1;
        elseif grupos(i)==2
            grupo_ASNP(x,l)= Media_grupo;               %Realiza a média das ultimas 100 respostas para o grupo ASNP, desconsiderando os valores NaN.
            l=l+1;
        elseif grupos(i)==3
            grupo_DRRD(x,m)= Media_grupo;               %Realiza a média das ultimas 100 respostas para o grupo DRRD, desconsiderando os valores NaN.
            m=m+1;
        end
    end
    
    ASLP_sessoes(k)=nanmean(grupo_ASLP(:,k));
    ASNP_sessoes(k)=nanmean(grupo_ASNP(:,k));
    DRRD_sessoes(k)=nanmean(grupo_DRRD(:,k));
    
   

    plot(-1,-1,'ro', 'markerfacecolor','r'); hold on     %plota cada ponto antes de plotar os dados de cada grupo.
    plot(-1,-1,'b>', 'markerfacecolor','b')
    plot(-1,-1,'ks', 'markerfacecolor','k')
    legend('ASLP', 'ASNP','DRRD', 'location', 'northWest')
    plot (grupo_ASLP,'ro', 'markerfacecolor','r');
    plot (grupo_ASNP,'b>', 'markerfacecolor','b');
    plot (grupo_DRRD,'ks','markerfacecolor','k');
    xlim ([0 4])
    ylim ([0 3])
    xlabel('Sessões')
    ylabel('Tempo Médio')
    
    legend('ASLP', 'ASNP','DRRD', 'location', 'northWest')

%     print (['tempomedio','sessao', num2str(Sessao,2)], '-dpng');

end





